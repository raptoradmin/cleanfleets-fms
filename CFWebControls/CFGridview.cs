//using CFUtilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Web.UI;

namespace CFWebControls
{
    public class CFGridView : GridView
    {
        /* The purpose of this grid control is to provide automatic paging/sorting functionality for grids - giving the developer
		 * the option to store settings like PageIndex and SortExpression in ViewState (default) or Session (by the PersistAdvancedGridSettingsInSession property)
		 * The only unique aspect to this grid is that the data source is provided through the DataBindAdvanced method
		 * and the consumer should subscribe to the DataSourceRequest event that will fire when the grid pages/sorts
		 */

        public CFGridView()
        {
            this.PageIndexChanging += new GridViewPageEventHandler(CFAGridView_PageIndexChanging);
            this.Sorting += new GridViewSortEventHandler(CFAGridView_Sorting);

            this.DataBound += CFAGridView_DataBound;
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            if (this.HeaderRow != null)
                this.HeaderRow.TableSection = TableRowSection.TableHeader;

            if (this.FooterRow != null)
                this.FooterRow.TableSection = TableRowSection.TableFooter;

            if (AllowPaging && this.TopPagerRow != null)
                this.TopPagerRow.TableSection = TableRowSection.TableHeader;

            if (AllowPaging && this.BottomPagerRow != null)
                this.BottomPagerRow.TableSection = TableRowSection.TableFooter;
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (string.IsNullOrEmpty(this.EmptyDataText)) this.EmptyDataText = "No records found.";

            //for some reason, it matters that this be in init and not load (especially for the pager)
            //when it was in load, the pager buttons would not take effect until after a postback
            //set default properties for CFA standards
           
                this.PagerSettings.PageButtonCount = 5;
                this.PagerSettings.Mode = PagerButtons.NumericFirstLast;
                this.PagerStyle.CssClass = "pager";
            
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!this.Page.IsPostBack)
            {
                //why would you do this? If they have settings persisted in session, and you go back to the page, this changes their settings. stupid? maybe...
                //this.SelectedColumnSortDirection = System.Web.UI.WebControls.SortDirection.Ascending;
                if (this.Columns.Count > 0 && this.Columns[0] != null) if (string.IsNullOrEmpty(this.SelectedColumnSortExpression)) this.SelectedColumnSortExpression = this.Columns[0].SortExpression;
            }

         
                this.UseAccessibleHeader = true;
                this.CssClass = "fixedSummaryTable gridview";
                this.ShowHeaderWhenEmpty = true;
                this.AlternatingRowStyle.CssClass = "altRow";
          


            if (this.AllowCustomPaging)
                this.VirtualItemCount = this.GetPersistedValue<int>(PersistedTotalRowCountKey);
        }

        #region Public Control Properties

        public bool PersistAdvancedGridSettingsInSession { get; set; }
        public bool HideBorderOnEmptyData { get; set; }

        #endregion

        #region Public Properties

        public int SelectedPageIndex
        {
            get
            {
                return this.GetPersistedValue<int>(PersistedPageIndexKey);
            }
            set
            {
                this.SetPersistedValue(PersistedPageIndexKey, value);
            }
        }

        public string SelectedColumnSortExpression
        {
            get
            {
                return this.GetPersistedValue<string>(PersistedColumnSortExpressionKey);
            }
            set
            {
                this.SetPersistedValue(PersistedColumnSortExpressionKey, value);
            }
        }

        public SortDirection SelectedColumnSortDirection
        {
            get
            {
                return this.GetPersistedValue<SortDirection>(PersistedColumnSortDirectionKey);
            }
            set
            {
                this.SetPersistedValue(PersistedColumnSortDirectionKey, value);
            }
        }

        public int TotalRowCount
        {
            get
            {
                return this.GetPersistedValue<int>(PersistedTotalRowCountKey);
            }
        }

        public CFAGridViewSettings Settings
        {
            get
            {
                return new CFAGridViewSettings(
                                                this.SelectedPageIndex,
                                                this.PageSize,
                                                this.SelectedColumnSortExpression ?? (this.Columns.Count > 0 ? this.Columns[0].SortExpression : ""),
                                                this.SelectedColumnSortDirection.ToString());
            }
        }

        public string EmptyDataCssClass { get; set; }

        #endregion

        #region Private Control Properies
        /// <summary>
        /// Enable or Disable generating an empty table if no data rows in source
        /// </summary>
        [Description("Enable or disable generating an empty table with headers if no data rows in source"),
        Category("Misc"),
        DefaultValue("true")
        ]
        public bool ShowEmptyTable
        {
            get
            {
                object o = ViewState["ShowEmptyTable"];
                return (o != null ? (bool)o : true);
            }
            set
            {
                ViewState["ShowEmptyTable"] = value;
            }
        }
        /// <summary>
        /// Get or Set Text to display in empty data row
        /// </summary>
        [
        Description("Text to display in empty data row"),
        Category("Misc"),
        DefaultValue("")
        ]
        public string EmptyTableRowText
        {
            get
            {
                object o = ViewState["EmptyTableRowText"];
                return (o != null ? o.ToString() : string.Empty);
            }
            set
            {
                ViewState["EmptyTableRowText"] = value;
            }
        }
        /*
				 * The crazy naming by filepath+unique id is just to make sure that the key is unique per page + per grid
				 * Only because we 'may' store the selected settings in session, and it needs to be unique across the site
				 * I'm sorry. I do feel bad about the long key - and storing things in session. But we're stateless!
				 */

        private string PersistedPageIndexKey
        {
            get
            {
                return string.Format("{0}{1}{2}", "SelectedPageIndex", this.UniqueID, this.Page != null ? this.Page.Request.FilePath : "");
            }
        }

        private string PersistedColumnSortExpressionKey
        {
            get
            {
                return string.Format("{0}{1}{2}", "ColumnSortExpression", this.UniqueID, this.Page != null ? this.Page.Request.FilePath : "");
            }
        }

        private string PersistedColumnSortDirectionKey
        {
            get
            {
                return string.Format("{0}{1}{2}", "ColumnSortDirection", this.UniqueID, this.Page != null ? this.Page.Request.FilePath : "");
            }
        }

        private string PersistedTotalRowCountKey
        {
            get
            {
                return string.Format("{0}{1}{2}", "TotalRowCount", this.UniqueID, this.Page != null ? this.Page.Request.FilePath : "");
            }
        }

        #endregion
        /*
        protected override int CreateChildControls(System.Collections.IEnumerable dataSource, bool dataBinding)
        {
            int numRows = base.CreateChildControls(dataSource, dataBinding);

            //no data rows created, create empty table if enabled
            if (numRows == 0 && ShowEmptyTable)
            {
                //create table
                Table table = new Table();
                table.ID = this.ID;

                //create a new header row
                GridViewRow row = base.CreateRow(-1, -1, DataControlRowType.Header, DataControlRowState.Normal);

                //convert the exisiting columns into an array and initialize
                DataControlField[] fields = new DataControlField[this.Columns.Count];
                this.Columns.CopyTo(fields, 0);
                this.InitializeRow(row, fields);
                table.Rows.Add(row);

                //create the empty row
                row = new GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal);
                TableCell cell = new TableCell();
                cell.ColumnSpan = this.Columns.Count;
                cell.Width = Unit.Percentage(100);
                cell.Controls.Add(new LiteralControl(EmptyTableRowText));
                row.Cells.Add(cell);
                table.Rows.Add(row);

                this.Controls.Add(table);
            }

            return numRows;
        }
   */
    /// <summary>
    /// Use this data binding method to provide a datasource, bind the data to the datasource, and evaluate Sorting / Paging automatically.
    /// </summary>
    /// <param name="DataSource"></param>
    public void DataBindAdvanced<T>(IEnumerable<T> DataSource)
        {
            //if (!string.IsNullOrEmpty(this.SelectedColumnSortExpression))
            //{
            //    if (DataSource == null) return;

            //    //the tolist is so that .net server controls can handle paging/sorting the result
            //    if (this.SelectedColumnSortDirection == SortDirection.Ascending)
            //    {
            //        var results = DataSource.AsQueryable().OrderByProperty(this.SelectedColumnSortExpression).ToList();
            //        this.DataSource = results;
            //    }
            //    else //descending
            //    {
            //        var results = DataSource.AsQueryable().OrderByPropertyDescending(this.SelectedColumnSortExpression).ToList();
            //        this.DataSource = results;
            //    }
            //    this.PageIndex = this.SelectedPageIndex;
            //}
            //else
            //{
                this.DataSource = DataSource;
            //}

            //persist total row count
            if (DataSource != null)
                this.SetPersistedValue(PersistedTotalRowCountKey, DataSource.Count());

            this.DataBind();
        }

        /// <summary>
        /// Use this data binding method to provide a datasource and bind the data to the datasource.  Use of this version of the method
        /// assumes the sorting and paging has been done else where.  You provide the total row count of the data set since the data will only
        /// contain a subset of the actual results of a given query.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="DataSource"></param>
        /// <param name="totalRowCount"></param>
        public void DataBindAdvanced<T>(IEnumerable<T> DataSource, int totalRowCount)
        {
            if (DataSource == null) return;

            if (!this.AllowCustomPaging)
                throw new Exception("You must set CFAGridView attribute AllowCustomPaging=\"true\" to use this version of DataBindAdvanced");

            this.PageIndex = this.SelectedPageIndex;
            this.DataSource = DataSource;

            //persist total row count
            this.SetPersistedValue(PersistedTotalRowCountKey, totalRowCount);

            this.VirtualItemCount = totalRowCount;

            this.DataBind();
        }

        void CFAGridView_DataBound(object sender, EventArgs e)
        {
            if (this.Rows.Count == 0 && !this.ShowHeaderWhenEmpty)
            {
                this.CssClass = EmptyDataCssClass ?? "gridViewEmptyData";
            }
        }


        public int FooTableTabletColumnsToShow { get; set; } = 3;
        public int FooTablePhoneColumnsToShow { get; set; } = 0;

        protected override void OnRowDataBound(GridViewRowEventArgs e)
        {
            base.OnRowDataBound(e);

            //this code is specifically to allow footables to work with our grids on the job site
            if (e.Row.RowType == DataControlRowType.Header)
            {
                int index = 0;
                foreach (TableCell cell in e.Row.Cells)
                {
                    cell.Attributes.Add("data-type", "html");

                    // Break Point on table cells for view port of 992 or less, cells will be hiddend (Tablet)
                    if (index > FooTableTabletColumnsToShow)
                    {
                        cell.Attributes.Add("data-breakpoints", "md");
                    }

                    // Break Point on table cells for view port of 768 or less, cells will be hiddend (Phone)
                    else if (index > FooTablePhoneColumnsToShow)
                    {
                        cell.Attributes.Add("data-breakpoints", "xs md");
                    }
                    index++;
                }
            }
        }

        #region Standard Grid Events

        protected void CFAGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            //this.SelectedPageIndex = 0;

            if (this.SelectedColumnSortExpression == e.SortExpression)
            {
                this.SelectedColumnSortDirection = (this.SelectedColumnSortDirection == SortDirection.Ascending) ? SortDirection.Descending : SortDirection.Ascending;
            }
            else
            {
                this.SelectedColumnSortDirection = SortDirection.Ascending;
            }

            this.SelectedColumnSortExpression = e.SortExpression;

            DataSourceRequest();

            ////handle css for sort arrow indicator
            foreach (DataControlField c in this.Columns)
            {
                c.HeaderStyle.CssClass = "";

                if (c.SortExpression == this.SelectedColumnSortExpression)
                {
                    c.HeaderStyle.CssClass = (this.SelectedColumnSortDirection == SortDirection.Ascending) ? "sortAsc" : "sortDesc";
                }

            }
        }

        protected void CFAGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.SelectedPageIndex = this.PageIndex = e.NewPageIndex;

            DataSourceRequest();
        }

        #endregion

        #region New/Custom Events

        //this event should be used in the UI to provide the datasource to the datagrid and bind it using DataBindAdvanced()
        public delegate void OnDataSourceRequest();
        public event OnDataSourceRequest DataSourceRequest;

        #endregion

        #region Private Methods

        /// <summary>
        /// This method is used to return the appropriate value from the provided key out of ViewState or Session, depending upon grid settings.
        /// </summary>
        private T GetPersistedValue<T>(string Key)
        {
            if (this.PersistAdvancedGridSettingsInSession)
            {
                if (this.Page.Session[Key] == null) this.Page.Session[Key] = default(T); // string.Empty;
                return (T)this.Page.Session[Key];
            }
            else
            {
                if (this.ViewState[Key] == null) this.ViewState[Key] = default(T);
                return (T)this.ViewState[Key];
            }
        }

        /// <summary>
        /// Store the provided value in ViewState or Session depending upon grid settings.
        /// </summary>
        private void SetPersistedValue(string Key, object Value)
        {
            if (this.PersistAdvancedGridSettingsInSession)
            {
                this.Page.Session[Key] = Value;
            }
            else
            {
                this.ViewState[Key] = Value;
            }
        }



        #endregion

        public void ResetPersistedSettings()
        {
            this.SetPersistedValue(PersistedColumnSortExpressionKey, null);
            this.SetPersistedValue(PersistedColumnSortDirectionKey, null);
            this.SetPersistedValue(PersistedPageIndexKey, null);
            this.SetPersistedValue(PersistedTotalRowCountKey, null);
        }

    }

    [Serializable]
    public class CFAGridViewSettings
    {
        public int PageIndex { get; set; }
        public int PageSize { get; set; }
        public string SortExpression { get; set; }
        public string SortDirection { get; set; }
        public int TotalRowCount { get; set; }

        public CFAGridViewSettings(int pageIndex, int pageSize, string sortExpression, string sortDirection)
        {
            this.PageIndex = pageIndex;
            this.PageSize = pageSize;
            this.SortExpression = sortExpression;
            this.SortDirection = sortDirection;
        }
    }
}
