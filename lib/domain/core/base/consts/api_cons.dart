class ApiConst {
  //static const baseUrl = 'https://secure-land-mobile-app.onrender.com/api';
  static const userUrl = '/user';
  static const loginUrl = '/user/loginUser';
  static const signUpUrl = '/user/signupUser';
  static const getUserUrl = '/user/getUserDetails';
  static const googleSignInUrl = '/user/googleSignIn';
  static const createPropertyUrl = '/property/createProperty';
  static const getAllServicesUrl = '/service/getAllServices';
  //static const getPropertyUrl = '/property/getPropertiesByUserId?userId=';
  static const getPropertyDetailsUrl = '/property/getPropertyById?id=';
  static const getAllPropertyTypesUrl = '/property/getAllPropertyTypes';
  static const getAllContactMethodsUrl = '/contactMethod/getAllContactMethods';
  static const getServices =
      '/productmanagement/getPlansByServiceIdOrCategoryId';
  static const getSubServices =
      '/productmanagement/getUniqueCatageryProductsByServiceId';
  static const getTotalCost = '/totalCost/calculateTotalCost';
  static const fetchTotalCost = '/totalCost/getTotalCost?id=';
  static const sendingEmail = '/totalCost/sendTotalCost_Email?userid=';
  static const updateProfile = '/user/update-profile';
  static const myservices =
      'https://securelandapi.hashstack.in/api/totalCost/getTotalCostByUserIdAndServiceId?userId=';
  static const myserviceswithAdmindata =
      '/totalCost/getTotalCostByUserIdAndServiceIdForChat?userId=';
  static const servicebyid =
      'https://securelandapi.hashstack.in/api/totalCost/getTotalCost?id=';
  static const notifications =
      'https://securelandapi.hashstack.in/api/notfication/getNotificationsByUserId?userId=';
  static const units = '/unit/getAllUnits';
  static const forgotPassword = '/user/forgotPassword?email_number=';
  static const getOtp = '/user/getOTP?email_number=';
  static const resetPassword = '/user/resetPassword?';
  static const updateProperty = '/property/updateProperty';
  static const messagesbyId = '/chat/getAllMessages?request_id=';
  static const workProgressbyId =
      '/work/getWorkProgressByIdOrGetAllProgressByAgent?totalCostId=';
  static const createReview = '/work/createReview';
  static const updateMessagestatus = '/chat/updateMessageStatusAsReadOrDelete';
}
