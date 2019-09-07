using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity
{
    [Serializable]
    public abstract class BaseEntity<T> : IBaseEntity, ICloneable where T : BaseEntity<T>
    {

        public string Command { get; set; }
        public string CreateDate { get; set; }
        public long? CreatedBy { get; set; }

        public object Clone()
        {
            return CloneIt.Clone(this);
        }
    }
}
