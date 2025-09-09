using System.ComponentModel.DataAnnotations;

namespace backend.Validation
{
    public class DateRangeAttribute : ValidationAttribute
    {
        public override bool IsValid(object value)
        {
            if (value is DateTime dateValue)
            {
                DateTime now = DateTime.UtcNow;
                DateTime minDate = now.AddYears(-1);
                DateTime maxDate = now.AddYears(1);
                return minDate <= dateValue && dateValue <= maxDate;
            }
            return true;
        }
    }
}
