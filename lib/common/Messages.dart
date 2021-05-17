class Messages {
  String successTitle = "¡Excelente!";
  String errorTitle = "¡Ups!, hubo un problema";
  String warningTitle = "Advertencia";
  String logOutTitle = "Hasta luego";
  String logInTitle = "Bienvenido nuevamente";
  String registerTitle = "Bienvenido";

  // ---- Mensajes de cantidad en carrito ---- //
  String lessThanOneProduct = "No puedes llevar menos de un producto.";
  String moreThanStockProduct =
      "Has sobrepasado el stock del producto. Si desea pedir más productos, contactenos.";
  String errorInValidation =
      "El valor ingresado en cantidad no es el correcto.";

  // ---- Mensajes de Login forzado ---- //
  String forcedLogin =
      "Para realizar un pedido debes ingresar o crear una cuenta.";
  String clossedSession = "Tu session ha terminado, ingresa nuevamente.";

  // ---- Mensajes de Carrito ---- //
  String errorAddCart =
      "Hubo un error al agregar un producto al carrito, intente nuevamente en unos minutos.";
  String successAddCart = "Has agregado el producto correctamente al carrito.";
  String errorDeleteCart =
      "Hubo un error al eliminar el producto del carrito, intente nuevamente en unos minutos.";
  String successDeleteCart =
      "Has eliminado el producto correctamente del carrito.";
  String errorNoItemsInCart = "No hay productos en tu carrito.";

  // ---- Mensajes de Perfil ---- //
  String errorUpdateProfile =
      "Uno de los campos no ha sido completado de forma corrrecta.";
  String successUpdateProfile = "Has actualizado tus datos correcamente.";
  String errorUpdatePasswordEqual = "Las contraseñas no coinciden";
  String errorUpdatePasswordSize = "La contraseña es menor a 6 caracteres.";
  String successUpdatePassword = "Has actualizado tu contraseña correctamente.";

  // ---- Mensajes de Direcciones ---- //
  String errorCreateAddress =
      "No has completado correctamente el formulario de dirección.";
  String successCreateAddress = "Has agregado la nueva dirección.";
  String errorUpdateAddress =
      "No has completado correctamente el formulario de dirección.";
  String successUpdateAddress = "Has actualizado la dirección.";
  String successDeleteAddress = "Has eliminado la dirección.";

  // ---- Mensajes de Formulario ---- //
  String successFormContact =
      "Gracias por contactarnos, te estaremos enviando un correo pronto.";
  String successFormComplaintsBook =
      "Has enviado el mensaje correctamente y estaremos en contacto con usted en la brevedad posible.";
  String errorForm = "Complete los campos obligatorios del formulario";

  // ---- Mensajes de Orden ---- //
  String successOrderConfirmed = "Tu pedido ha sido recibido exitosamente.";
  String errorDirectionCantBeUsed =
      "Has elegido una dirección a la cual no hacemos envio.";
  String errorOrderReject =
      "Lo sentimos, su pedido ha sido rechazado. Intenta nuevamente en unos minutos.";
  String errorOrderForm =
      "No has terminado de llenar los detalles de facturación.";

  // ---- Mensajes de Payment ---- //
  String successPaymentConfirmed = "Has realizado el pago de tu pedido.";
  String errorPaymentToken =
      "No se ha podido contactar con el método de pago. Intenta nuevamente en unos minutos.";
  String errorPaymentForm = "Los campos que has completado tienen error.";

  // ---- Mensajes de LogOut ---- //
  String successLogOut =
      "¡Esperamos regreses pronto! Te estaremos esperando con más sorpresas.";

  // ---- Mensajes de LogIn ---- //
  String successLogIn = "¡Hola! Nos alegra que regreses.";
  String errorLogIn =
      "Hubo un error al ingresar. Intenta nuevamente en unos minutos.";
  String errorFormLogIn =
      "No has ingresado el usario o la contraséña correcta.";

  // ---- Mensajes de Register ---- //
  String successRegister = "Esperamos nuestros productos te agraden.";
  String errorFormRegister = "No has llenado los campos correctamente.";

  // ---- Mensaje General de Error ---- //
  String errorGeneral =
      "Ha ocurrido un error. Intente nuevamente en unos minutos.";

  // ---- Mensaje Detalle de Producto ---- //
  String noStockProduct =
      "El producto no esta en stock, aun puede pedir otra de sus presentaciones.";
}
