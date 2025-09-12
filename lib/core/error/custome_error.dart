
String errorConvertor(int? statusCode, String? message) {
  if (statusCode != null) {
    switch (statusCode) {
      case 500:
        return "ارتباط با سرور برقرار نشد لطفا چند دقیقه دیگر مجددا تلاش کنید";
      case 429:
        return "متاسفانه درخواست شما زیاد است لطفا مجددا تلاش کنید";
      case 401:
        return "شما دسترسی لازم را ندارید";
      case 404:
        return "عکس مرتبط با غذا نیست";
       case 403:
        return "در خواست شما مجاز نیست لطفا با پشتیبانی ارتباط بگیرید";
      case 413:
      return "حجم فایل بیش از حد مجاز است لطفا حجم فایل را کاهش دهید"; 
      case 400:
      return "کد وارد شده اشتباه است"; 
      case 422:
      return "مقادیر وارد شده صحیح نیست";  
      default:
        return message ?? 'خطای نامشخص';
    }
  } else {
    return message ?? 'خطای نامشخص';
  }
}

