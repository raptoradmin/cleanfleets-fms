CREATE VIEW [dbo].[CFV_Profile_Contact]
AS
SELECT        dbo.CF_Profile_Contact.IDProfileContact, dbo.aspnet_Users.UserId, dbo.aspnet_Users.UserName, dbo.aspnet_Membership.Password, 
                         dbo.CF_Profile_Contact.IDProfileAccount,
                             (SELECT        AccountName
                               FROM            dbo.CFV_Accounts
                               WHERE        (dbo.CF_Profile_Contact.IDProfileAccount = IDProfileAccount)) AS Account, dbo.CF_Profile_Contact.IDModifiedUser, 
                         dbo.CF_Profile_Contact.ModifiedDate, dbo.CF_Profile_Contact.IDPrefix,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_4
                               WHERE        (dbo.CF_Profile_Contact.IDPrefix = IDOptionList)) AS Prefix, dbo.CF_Profile_Contact.IDPostfix,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_1
                               WHERE        (dbo.CF_Profile_Contact.IDPostfix = IDOptionList)) AS Postfix, dbo.CF_Profile_Contact.IDTitle,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_2
                               WHERE        (dbo.CF_Profile_Contact.IDTitle = IDOptionList)) AS Title, dbo.CF_Profile_Contact.LastName, dbo.CF_Profile_Contact.FirstName, 
                         dbo.CF_Profile_Contact.MI, dbo.CF_Profile_Contact.FirstName + ' ' + dbo.CF_Profile_Contact.LastName AS ContactName, dbo.aspnet_Membership.Email, 
                         dbo.CF_Profile_Contact.Address1, dbo.CF_Profile_Contact.Address2, dbo.CF_Profile_Contact.City, dbo.CF_Profile_Contact.State, 
                         dbo.CF_Profile_Contact.County, dbo.CF_Profile_Contact.Country, dbo.CF_Profile_Contact.Zip, dbo.CF_Profile_Contact.Telephone1, 
                         dbo.CF_Profile_Contact.Ext1, dbo.CF_Profile_Contact.Telephone2, dbo.CF_Profile_Contact.Ext2, dbo.CF_Profile_Contact.Telephone3, 
                         dbo.CF_Profile_Contact.Ext3, dbo.CF_Profile_Contact.CellPhone, dbo.CF_Profile_Contact.Fax1, dbo.CF_Profile_Contact.Fax2, dbo.CF_Profile_Contact.Notes, 
                         dbo.CF_Profile_Contact.NotesCF, dbo.aspnet_Roles.RoleName, dbo.aspnet_Membership.PasswordQuestion, dbo.aspnet_Membership.PasswordAnswer, 
                         dbo.CF_Profile_Contact.EnterDate, 
                         dbo.CF_Profile_Contact.MailMergeCode, dbo.CF_Profile_Contact.EMailMergeCode, dbo.CF_Profile_Contact.WebSite
FROM            dbo.aspnet_Users INNER JOIN
                         dbo.CF_Profile_Contact ON dbo.aspnet_Users.UserId = dbo.CF_Profile_Contact.UserID INNER JOIN
                         dbo.aspnet_UsersInRoles ON dbo.aspnet_Users.UserId = dbo.aspnet_UsersInRoles.UserId INNER JOIN
                         dbo.aspnet_Roles ON dbo.aspnet_UsersInRoles.RoleId = dbo.aspnet_Roles.RoleId INNER JOIN
                         dbo.aspnet_Membership ON dbo.aspnet_Users.UserId = dbo.aspnet_Membership.UserId
WHERE        (dbo.aspnet_Roles.RoleName = N'Client')
