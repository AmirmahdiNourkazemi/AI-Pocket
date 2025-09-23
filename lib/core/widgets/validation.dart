class Validation {
  static String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'لطفا شماره موبایل خود را وارد کنید';
    } else if (value.length != 11) {
      return 'شماره موبایل صحیح نمی باشد';
    } else {
      return null;
    }
  }


  static String? validateSeacrhText(String? value) {
    if (value!.isEmpty) {
      return 'لطفا متن جستجو را وارد کنید';
    }  else {
      return null;
    }
  }

    static  int? calculateRemainingDays(DateTime? expire_date) {
      if (expire_date == null) return null;

      final currentDate = DateTime.now();

      final difference = expire_date.difference(currentDate).inDays + 1;

      return difference >= 0 ? difference : 0; // Return 0 if expired
    }
}
