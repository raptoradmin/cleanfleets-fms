using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FMS.Repository;
using Microsoft.EntityFrameworkCore;

namespace FMS.Business
{
    public abstract class BaseBusiness : IDisposable  
    {
        internal FMSRepoContext context;
        public BaseBusiness()
        {
            context = new FMSRepoContext();
        }

        public void SaveContext()
        {
            //var now = DateTime.Now;
            //var entries = context.ChangeTracker.Entries().Where(e => EntityState.Added == e.State || EntityState.Modified == e.State).ToList();

            //foreach(var e in entries)
            //{
            //    var item = e.Entity as IAuditedEntity;
            //}

            context.SaveChanges();
        }

        public void Dispose()
        {
            this.context = null;
        }
    }
}
