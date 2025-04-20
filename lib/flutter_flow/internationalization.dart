import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['zh_Hans', 'es', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? zh_HansText = '',
    String? esText = '',
    String? enText = '',
  }) =>
      [zh_HansText, esText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    'cuwmn1h1': {
      'zh_Hans': 'Ingo',
      'en': 'Ingo',
      'es': 'Ingo',
    },
    '4kx8pgjv': {
      'zh_Hans': 'Sharing is the new Phylosophy',
      'en': 'Sharing is the new Phylosophy',
      'es': 'Sharing is the new Phylosophy',
    },
    'xbify3qy': {
      'zh_Hans': ' 即刻起注册您的账户！',
      'en': 'Creat new account right now!',
      'es': '¡Crea una cuenta nueva ahora mismo!',
    },
    '61dd1tks': {
      'zh_Hans': '用户名',
      'en': 'Username',
      'es': 'Usuario',
    },
    '91wh74cy': {
      'zh_Hans': '电子邮箱',
      'en': 'Email',
      'es': 'Email',
    },
    'z6b6je7s': {
      'zh_Hans': '设置密码',
      'en': 'Creat password',
      'es': 'Configura contraseña',
    },
    'upjt43x3': {
      'zh_Hans': '确认密码',
      'en': 'Confirm password',
      'es': 'Confirma la contraseña',
    },
    '9564qwck': {
      'zh_Hans': '点击注册账户',
      'en': 'Click and creat new account',
      'es': 'Haz click y crea tu cuenta',
    },
    'uq0jfrsb': {
      'zh_Hans': '已经注册过账户？',
      'en': 'Already has an account?',
      'es': 'Ya has registrado una cuenta?',
    },
    'm2bjxhs6': {
      'zh_Hans': '点击登录已有账户',
      'en': 'Log in your account',
      'es': 'Log in tu cuenta ',
    },
    '1lce7fo7': {
      'zh_Hans': 'Empowered By Brillate.com',
      'en': 'Empowered By Brillate.com',
      'es': 'Empowered By Brillate.com',
    },
    'r4df2bb0': {
      'zh_Hans': 'Home',
      'en': 'Home',
      'es': 'Home',
    },
  },
  // Home
  {
    'wtlokzpf': {
      'zh_Hans': '退出登录',
      'en': 'Log out',
      'es': 'Salir de cuenta',
    },
    '78uunf95': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // MyProfile
  {
    't3q4x3l7': {
      'zh_Hans': 'Posts',
      'en': 'Posts',
      'es': 'Posts',
    },
    '1vopxdo4': {
      'zh_Hans': 'Followers',
      'en': 'Followers',
      'es': 'Seguidores',
    },
    'uvcclsxl': {
      'zh_Hans': 'Following',
      'en': 'Following',
      'es': 'Siguiendo',
    },
    'j2q0mad8': {
      'zh_Hans': '编辑个人资料',
      'en': 'Edit Info',
      'es': 'Editar datos ',
    },
    'rcolthc5': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Chat_List
  {
    'k52byf37': {
      'zh_Hans': '私信栏',
      'en': 'Messages',
      'es': 'Mensajes',
    },
    '9icmcdbg': {
      'zh_Hans': '私信',
      'en': 'Messages',
      'es': 'Mensajes',
    },
    'baxsr9kx': {
      'zh_Hans': '通知',
      'en': 'Notification',
      'es': 'Notificación',
    },
    'bjigauv5': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Explore
  {
    'uesmt4fq': {
      'zh_Hans': '搜一搜...',
      'en': 'Explore',
      'es': 'Explora',
    },
    'pb47ib4i': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Post
  {
    'pdxb06ti': {
      'zh_Hans': '添加描述',
      'en': 'Add description',
      'es': 'Añade descripción',
    },
    'br39r8wx': {
      'zh_Hans': '所在城市',
      'en': 'City',
      'es': 'Ciudad',
    },
    'x3o7nvxx': {
      'zh_Hans': '点击确认',
      'en': 'Click and confirm',
      'es': 'Click y confirmar',
    },
    'kvtp2rlr': {
      'zh_Hans': '点击确认',
      'en': 'Click and confirm',
      'es': 'Click y confirmar',
    },
    'hop1poyt': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // EditProfile
  {
    'lylh5v5m': {
      'zh_Hans': '返回',
      'en': 'Back',
      'es': 'Volver',
    },
    'kg1xkjs5': {
      'zh_Hans': '编辑主页',
      'en': 'Edit Profile',
      'es': 'Editar Perfile',
    },
    'm4tjnwuf': {
      'zh_Hans': '确认',
      'en': 'Confirm',
      'es': 'Confirmar',
    },
    '8uzqzlfi': {
      'zh_Hans': '更换头像',
      'en': 'Change profile image',
      'es': 'Cambiar foto de perfile',
    },
    '93wiwze2': {
      'zh_Hans': '用户名',
      'en': 'Username',
      'es': 'Usuario',
    },
    'tu7zufm6': {
      'zh_Hans': '个人介绍',
      'en': 'Description',
      'es': 'Descripción',
    },
    '6o9cmu0i': {
      'zh_Hans': '网址',
      'en': 'Website',
      'es': 'Website',
    },
    'rj8cqea2': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // User_post
  {
    'wdz6y1uv': {
      'zh_Hans': '帖子',
      'en': 'Posts',
      'es': 'Posts',
    },
    'cyp7z2gs': {
      'zh_Hans': '  ',
      'en': '',
      'es': '',
    },
    '7nz0rvd3': {
      'zh_Hans': '发布日期',
      'en': 'Publication date',
      'es': 'Fecha de publicación',
    },
    '4sljc331': {
      'zh_Hans': '查看',
      'en': 'See',
      'es': 'Ver los',
    },
    'zepw9bsr': {
      'zh_Hans': '条评论',
      'en': 'comments',
      'es': 'comentarios',
    },
    'ehbn9kwj': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // UsersPage
  {
    'tkav54tm': {
      'zh_Hans': 'Posts',
      'en': '',
      'es': '',
    },
    '4ozkx29y': {
      'zh_Hans': 'Followers',
      'en': '',
      'es': '',
    },
    'f8y80uoj': {
      'zh_Hans': 'Following',
      'en': '',
      'es': '',
    },
    'cgmquefy': {
      'zh_Hans': 'Follow',
      'en': 'Follow',
      'es': 'Seguir',
    },
    '54pztqq4': {
      'zh_Hans': 'Unfollow',
      'en': 'Unfollow',
      'es': 'Dejar de seguir',
    },
    'aygwrogy': {
      'zh_Hans': '发信息',
      'en': 'Send Messages',
      'es': 'Enviar mensajes',
    },
    'db4csp2v': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // FavoritePosts
  {
    'rb45axb8': {
      'zh_Hans': '赞过',
      'en': 'Likes',
      'es': 'Likes',
    },
    's8lzebpj': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // BookMarkPosts
  {
    'hs3dwcup': {
      'zh_Hans': '收藏',
      'en': 'Favorites',
      'es': 'Favorito',
    },
    '4fpv5wnp': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // Followers_Following
  {
    'hfr12582': {
      'zh_Hans': 'Followers',
      'en': 'Followers',
      'es': 'Seguidores',
    },
    '590nqi3s': {
      'zh_Hans': '删除',
      'en': 'Delete',
      'es': 'Eliminar',
    },
    '1nuek9wq': {
      'zh_Hans': 'Follow',
      'en': 'Follow',
      'es': 'Seguir',
    },
    '1lb8cym9': {
      'zh_Hans': 'UnFollow',
      'en': 'Unfollow',
      'es': 'Deja de seguir',
    },
    'cmb12buu': {
      'zh_Hans': 'Following',
      'en': 'Following',
      'es': 'Siguiendo',
    },
    'yjbqtadv': {
      'zh_Hans': 'Unfollow',
      'en': 'Unfollow',
      'es': 'Deja de seguir',
    },
    'pdn42u74': {
      'zh_Hans': 'Follow',
      'en': 'Follow',
      'es': 'Seguir',
    },
    'qoewio89': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // chat
  {
    'eg8g1fib': {
      'zh_Hans': '打声招呼吧',
      'en': 'Hi',
      'es': 'Hola',
    },
    '5qtp59sv': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // chat_intermediate
  {
    'ao830jxl': {
      'zh_Hans': '粉丝',
      'en': 'Followers',
      'es': 'Seguidores',
    },
    'ul33r7sa': {
      'zh_Hans': '·',
      'en': '',
      'es': '',
    },
    '2klefxdd': {
      'zh_Hans': '个帖子',
      'en': 'Posts',
      'es': 'Posts',
    },
    'z9t8gxyh': {
      'zh_Hans': '打声招呼吧',
      'en': 'Send a message',
      'es': 'Envia un mensaje',
    },
    'sswa5llq': {
      'zh_Hans': '查看用户首页',
      'en': '',
      'es': '',
    },
    '1tiabeg9': {
      'zh_Hans': '打声招呼吧',
      'en': '',
      'es': '',
    },
    '5iwzdv9y': {
      'zh_Hans': 'Home',
      'en': '',
      'es': '',
    },
  },
  // LogIn
  {
    '4b9jca5z': {
      'zh_Hans': '输入您的账户信息',
      'en': 'Fill in your account info',
      'es': 'Introduce  tu cuenta',
    },
    '9z8tu85e': {
      'zh_Hans': '电子邮箱',
      'en': '',
      'es': '',
    },
    '388x77vu': {
      'zh_Hans': '密码',
      'en': 'Password',
      'es': 'Contraseña',
    },
    'q9tf4jlf': {
      'zh_Hans': '点击登录',
      'en': 'Log in',
      'es': 'Log in',
    },
    '6ic9bt5b': {
      'zh_Hans': '忘记密码？',
      'en': 'Forget your password?',
      'es': '¿Olvidaste la contraseña?',
    },
  },
  // EditPhoto
  {
    'yso0v1bk': {
      'zh_Hans': '上传图片',
      'en': 'Upload picture',
      'es': 'Subir foto',
    },
    '8aou04k2': {
      'zh_Hans': '删除图片',
      'en': 'Delete Images',
      'es': 'Elimina fotos',
    },
  },
  // Select_photos
  {
    'x71wlngq': {
      'zh_Hans': '原相机拍照',
      'en': 'Take pictures',
      'es': 'Tomar foto',
    },
    '32yys2go': {
      'zh_Hans': '查看相册',
      'en': 'Image Gallery',
      'es': 'Galería de fotos',
    },
  },
  // ProfileOptions
  {
    'xpsqg8p8': {
      'zh_Hans': '菜单',
      'en': 'Menu',
      'es': 'Menú',
    },
    'bxa58z12': {
      'zh_Hans': '点赞',
      'en': 'Likes',
      'es': 'Likes',
    },
    'nb56h1kd': {
      'zh_Hans': '收藏',
      'en': 'Favorites',
      'es': 'Favoritos',
    },
    'a21zjeji': {
      'zh_Hans': '退出登录',
      'en': 'Log out',
      'es': 'Log out',
    },
  },
  // LogOut
  {
    'khiarxrx': {
      'zh_Hans': '您确定要退出登录吗？',
      'en': 'Are you sure to log out?',
      'es': 'Estás seguro que quieres salir de tu cuenta?',
    },
    'udbyjxt6': {
      'zh_Hans': '退出登录',
      'en': 'Log out',
      'es': 'Salir de tu cuenta',
    },
    'pgs0iwk4': {
      'zh_Hans': '暂不退出',
      'en': 'Not for the moment',
      'es': 'De momento no',
    },
  },
  // Comments
  {
    'fbyw0jx2': {
      'zh_Hans': '评论',
      'en': 'Comments',
      'es': 'Comentarios',
    },
    'fxfw2myo': {
      'zh_Hans': '赞',
      'en': 'Likes',
      'es': 'Likes',
    },
    'zx8znuc4': {
      'zh_Hans': '回复',
      'en': 'Reply',
      'es': 'Contestar',
    },
    'ic6neqvf': {
      'zh_Hans': '查看其他',
      'en': 'Check others',
      'es': 'Mirar otros',
    },
    'g2e6mekg': {
      'zh_Hans': '条回复',
      'en': 'Comments',
      'es': 'Respuestas',
    },
    'qcr09a92': {
      'zh_Hans': '点击这里留下您的宝贵点评哦...',
      'en': 'Leave your commment',
      'es': 'Deja tu comentario',
    },
    '8xw83d7i': {
      'zh_Hans': '您正在回复  ',
      'en': 'Replying',
      'es': 'Estás respondiendo',
    },
    'eu99hxfq': {
      'zh_Hans': '点击这里留下您的宝贵点评哦...',
      'en': 'Leave your commment...',
      'es': 'Deja un comentario...',
    },
  },
  // ButtonSheet_ChatPhoto
  {
    'ek6kjbe0': {
      'zh_Hans': '相机',
      'en': 'Camera',
      'es': 'Cámara',
    },
    'e0ttb5y4': {
      'zh_Hans': '相册',
      'en': 'Gallery',
      'es': 'Galería',
    },
  },
  // PickPlace
  {
    'jtawi16p': {
      'zh_Hans': '选择所在地',
      'en': 'Location',
      'es': 'Localización',
    },
    'h8liz113': {
      'zh_Hans': '确认',
      'en': 'Confirm',
      'es': 'Confirmar',
    },
  },
  // SelectLanguage
  {
    'ujtvgh1m': {
      'zh_Hans': '请选择语言',
      'en': '',
      'es': '',
    },
    '9vhncfgt': {
      'zh_Hans': '英文',
      'en': 'English',
      'es': 'Inglés',
    },
    'jax6dna3': {
      'zh_Hans': '西班牙语',
      'en': 'Spanish',
      'es': 'Español',
    },
    'imahivzf': {
      'zh_Hans': '简体中文',
      'en': 'Simplified Chinese',
      'es': 'Chino Simplificado',
    },
  },
  // Miscellaneous
  {
    'nle8ztef': {
      'zh_Hans': '该app需要您的授权才能使用拍照或摄像功能',
      'en':
          'In order to take a picture or video, this app requires permission to access the camera.',
      'es':
          'Para tomar foto o vídeo, este app requiere permiso para acceder a la cámara.',
    },
    'bv5qq43w': {
      'zh_Hans': '该app需要授权才能上传文件。',
      'en':
          'In order to upload data, this app requires permission to access the photo library.',
      'es':
          'Para subir datos, este app requirer permiso para acceder a la galería de fotos.',
    },
    '8cqkt43s': {
      'zh_Hans': '出错了: [出错了]',
      'en': 'Error: [Error]',
      'es': 'Error: [Error]',
    },
    'er8g34zg': {
      'zh_Hans': '密码重置邮件已发送！',
      'en': 'Password reset email sent!',
      'es': 'Email de re-configurar la contraseña ha sido enviado!',
    },
    'f4ljuys3': {
      'zh_Hans': '请填写电子邮箱！',
      'en': 'Email required!',
      'es': 'Email requerido!',
    },
    'a9nud3py': {
      'zh_Hans': '请输入电话号码并以+开始。',
      'en': 'Phone number required and has to start with+.',
      'es': 'Se requiere número de teléfono y se debe empezar con +. ',
    },
    '9xn0y6zn': {
      'zh_Hans': '密码不正确。',
      'en': 'Passwords don´t match.',
      'es': 'Contraseña no coincide.',
    },
    'rov19h8b': {
      'zh_Hans': '请输入短信验证码。',
      'en': 'Enter SMS vertification code. ',
      'es': 'Introduce verificación SMS código.',
    },
    '3zqo9xav': {
      'zh_Hans': '自最近一次登录以来时间太长。删除帐户前请重新登录。',
      'en':
          'Too long since most recent sign in. Sign in again before deleting your account.',
      'es':
          'Ha pasado demasiado tiempo desde el último inicio de sesión. Inicie sesión nuevamente antes de eliminar su cuenta.',
    },
    'o88w5c8o': {
      'zh_Hans': '自最近一次登录以来时间太长。更新电子邮箱前请重新登录。',
      'en':
          'Too long since most recent sign in. Sign in again before updating your email.',
      'es':
          'Ha pasado demasiado tiempo desde el último inicio de sesión. Inicie sesión nuevamente antes de actualizar tu email.',
    },
    '5zexj1jg': {
      'zh_Hans': '电子邮箱变更确认邮件已发送！',
      'en': 'Email change confirmation email sent!',
      'es': 'Email de confirmación del cambio de email ha sido enviado!',
    },
    'kzlhme5h': {
      'zh_Hans': '该邮箱已被注册。',
      'en': 'Email already in use by another account.',
      'es': 'Email ya ha sido registrado por otra cuenta.',
    },
    'l9imjye5': {
      'zh_Hans': '提供的身份验证不正确, 格式错误或已过期。',
      'en':
          'The supplied auth credential is incorrect, malformed or has expired.',
      'es':
          'La credencial de autenticación proporcionada es incorrecta, está malformada o ha expirado.',
    },
    'dc37oqz9': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'vcqb083h': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'z9lnfq3q': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'bfmaanuo': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'h0f0pp3y': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'of8woqm2': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'mci7pec8': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'uh39sw4m': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    '2vh3xxdw': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    '06xa3w7y': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'vuykw25m': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'mb16e13l': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    '3bkn3uao': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
    'gbye3dnm': {
      'zh_Hans': '',
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
