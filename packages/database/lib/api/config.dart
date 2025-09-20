import 'urls.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: Server end-points configurations, TODO need to move this to flavours
 */
class Config {
  static Server serverPointing = Server.prod;

  static Role role = Role.student;
  static var isAppActive = 0;
  static String? _baseURL;
  static String? _baseUploadURL;
  static String get baseURL {
    if (_baseURL == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _baseURL = BaseAddress.prod.value + BaseVD.prod.value;
          }
          break;
        case Server.uat:
          {
            _baseURL = BaseAddress.uat.value + BaseVD.uat.value;
          }
          break;
        default:
          {
            _baseURL = BaseAddress.testing.value + BaseVD.testing.value;
            break;
          }
      }
    }
    return _baseURL ?? "";
  }

  static String get baseUploadURL {
    if (_baseUploadURL == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _baseUploadURL =
                BaseAddress.prod.value + BaseVDForUpload.prod.value;
          }
          break;
        case Server.uat:
          {
            _baseUploadURL = BaseAddress.uat.value + BaseVDForUpload.uat.value;
          }
          break;
        default:
          {
            _baseUploadURL =
                BaseAddress.testing.value + BaseVDForUpload.testing.value;
            break;
          }
      }
    }
    return _baseUploadURL ?? "";
  }

  static String? _repositoryUrl;
  static String get repositoryUrl {
    if (_repositoryUrl == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _repositoryUrl = BaseAddress.prod.value + RepositoryVD.prod.value;
          }
          break;
        case Server.uat:
          {
            _repositoryUrl = BaseAddress.uat.value + RepositoryVD.uat.value;
          }
          break;
        default:
          {
            _repositoryUrl =
                BaseAddress.testing.value + RepositoryVD.testing.value;
            break;
          }
      }
    }
    return _repositoryUrl ?? "";
  }

  static String? _reportsUrl;
  static String get reportsUrl {
    if (_reportsUrl == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _reportsUrl = BaseAddress.prod.value + ReportsVD.prod.value;
          }
          break;
        case Server.uat:
          {
            _reportsUrl = BaseAddress.uat.value + ReportsVD.uat.value;
          }
          break;
        default:
          {
            _reportsUrl = BaseAddress.testing.value + ReportsVD.testing.value;
            break;
          }
      }
    }
    return _reportsUrl ?? "";
  }

  static String? _baseAddress;
  static String get baseAddress {
    if (_baseAddress == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _baseAddress = BaseAddress.prod.value;
          }
          break;
        case Server.uat:
          {
            _baseAddress = BaseAddress.uat.value;
          }
          break;
        default:
          {
            _baseAddress = BaseAddress.testing.value;
            break;
          }
      }
    }
    return _baseAddress ?? "";
  }

  static String? _palUrl;
  static String get palUrl {
    if (_palUrl == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _palUrl = PALUrl.prod.value;
          }
          break;
        case Server.uat:
          {
            _palUrl = PALUrl.uat.value;
          }
          break;
        default:
          {
            _palUrl = PALUrl.testing.value;
            break;
          }
      }
    }
    return _palUrl ?? "";
  }

  static String? _privacyPolicyUrl;
  static String get privacyPolicyUrl {
    if (_privacyPolicyUrl == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _privacyPolicyUrl = PrivacyPolicyUrl.prod.value;
          }
          break;
        case Server.uat:
          {
            _privacyPolicyUrl = PrivacyPolicyUrl.uat.value;
          }
          break;
        default:
          {
            _privacyPolicyUrl = PrivacyPolicyUrl.testing.value;
            break;
          }
      }
    }
    return _privacyPolicyUrl ?? "";
  }

  String? _reportsVD;
  String get reportsVD {
    if (_reportsVD == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _reportsVD = ReportsVD.prod.value;
          }
          break;
        case Server.uat:
          {
            _reportsVD = ReportsVD.uat.value;
          }
          break;
        default:
          {
            _reportsVD = ReportsVD.testing.value;
            break;
          }
      }
    }
    return _reportsVD ?? "";
  }

  String? _multipartFileUrl;
  String get multipartFileUrl {
    if (_multipartFileUrl == null) {
      switch (serverPointing) {
        case Server.prod:
          {
            _multipartFileUrl =
                BaseAddress.prod.value + BaseVD.prod.value + Urls.fileURL;
          }
          break;
        case Server.uat:
          {
            _multipartFileUrl =
                BaseAddress.uat.value + BaseVD.uat.value + Urls.fileURL;
          }
          break;
        default:
          {
            _multipartFileUrl =
                BaseAddress.testing.value + BaseVD.testing.value + Urls.fileURL;
            break;
          }
      }
    }
    return _baseURL ?? "";
  }

  static String? _helpUrl;
  static String get helpUrl {
    _helpUrl ??= role == Role.student
        ? HelpUrlMyBagApp.prod.value
        : HelpUrlMyClassApp.prod.value;
    return _helpUrl ?? "";
  }
}

enum Server {
  testing(0),
  uat(1),
  prod(2);

  const Server(this.value);
  final int value;
}

enum BaseAddress {
  testing("https://oxfordcontent-uat.excelindia.com/"),
  uat("https://oxford-uat.excelindia.com/"),
  prod("https://oxfordadvantage.co.in/");

  const BaseAddress(this.value);
  final String value;
}

//
enum BaseVD {
  testing("OUPIProductMobileServiceContent/"),
  uat("OUPIProductMobileServiceUAT/"),
  prod("OUPIProductMobileServiceLive/");

  const BaseVD(this.value);
  final String value;
}

//
enum BaseVDForUpload {
  testing("OUPIProductMobileUploadServiceContent/"),
  uat("OUPIProductMobileUploadServiceUAT/"),
  prod("OUPIProductMobileUploadServiceLive/");

  const BaseVDForUpload(this.value);
  final String value;
}

enum RepositoryVD {
  testing("OUPI_RootRepository/"),
  uat("OUPI_RootRepository/"),
  prod("OA_RootRepository/");

  const RepositoryVD(this.value);
  final String value;
}

enum HelpUrlMyBagApp {
  prod(
      "https://oxfordadvantage.co.in/OA_MobileResources/Help/myBag/Content/Home.htm");

  const HelpUrlMyBagApp(this.value);
  final String value;
}

enum HelpUrlMyClassApp {
  prod(
      "https://oxfordadvantage.co.in/OA_MobileResources/Help/myClass/Content/Home.htm");

  const HelpUrlMyClassApp(this.value);
  final String value;
}

class PALUrl {
  final String value;
  PALUrl._(this.value);

  static PALUrl testing = PALUrl._("https://global.oup.com/privacy?cc=gb");
  static PALUrl uat =
      PALUrl._("http://pal-org.s3-website.ap-south-1.amazonaws.com/?");
  static PALUrl prod = PALUrl._(_getPalUrl());

  static String _getPalUrl() {
    if (Config.role == Role.student) {
      return "https://deyzgzw8j4zpk.cloudfront.net/?";
    } else {
      return "https://d1ku64o24ixl3a.cloudfront.net/?";
    }
  }
}

enum PrivacyPolicyUrl {
  testing("https://global.oup.com/privacy?cc=gb"),
  uat("https://global.oup.com/privacy?cc=gb"),
  prod("https://global.oup.com/privacy?cc=gb");

  const PrivacyPolicyUrl(this.value);
  final String value;
}

enum ReportsVD {
  testing("OxfordAdvantageUAT"),
  uat("OxfordAdvantageUAT"),
  prod("OxfordAdvantage");

  const ReportsVD(this.value);
  final String value;
}

enum Role {
  student("student"),
  teacher("teacher");

  const Role(this.value);
  final String value;
}
