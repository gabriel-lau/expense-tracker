using System.ComponentModel.DataAnnotations;

namespace backend.Validation
{
    public class UTCFormatAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            if (value is DateTime dateValue)
            {
                return dateValue.Kind == DateTimeKind.Utc;
            }
            return true;
        }
    }
}
