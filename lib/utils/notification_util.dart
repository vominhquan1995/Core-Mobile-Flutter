abstract class JsonTO {
  Map<String, dynamic> toJson();
}

class NotificationUtil {
  static final int idTabNotifi = 2;
  static final int idPageNotifi = 0;
  static int idPageTT = 4;
  static String keyPreState = 'stateNotifi';
  static String keyPreError = 'errorNotifi';
  static String keyNotifi = 'state';
  static String keyTopicTT = 'topic_tintuc';
  static bool configStateDefault = true;
  static bool configStateTopicDefault = false;
  static int idTopicTT = 4;
  static const Map<String, dynamic> list_page_notification = {
    "0": {
      "ten": "tb",
      "icon": "",
      "sound": "",
      "detail": true,
      "tag_users": {"1937": "{}"}
    },
    "1": {
      "ten": "vb",
      "icon": "",
      "sound": "",
      "detail": true,
      "tag_users": {"1937": "{}"}
    },
    "2": {
      "ten": "vpgd",
      "icon": "",
      "sound": "",
      "detail": true,
      "tag_users": {"1937": "{}"}
    },
    "3": {
      "ten": "nbgd",
      "icon": "",
      "sound": "",
      "detail": true,
      "tag_users": {"1937": "{}"}
    },
    "4": {
      "ten": "tt",
      "icon": "",
      "sound": "",
      "tag_users": {"1937": "{}"}
    },
    "5": {
      "ten": "tvhd",
      "icon": "",
      "sound": "",
      "detail": true,
      "tag_users": {"1937": "{}"}
    },
    "6": {
      "ten": "tuyendung",
      "icon": "",
      "sound": "",
      "detail": true,
      "tag_users": {"1937": "{}"}
    }
  };
  static const Map<String, dynamic> list_topic_notification = {
    "0": {
      "key": "state",
      "value": 'true',
    },
    "1": {
      "key": "topic_tintuc",
      "value": 'true',
    }
  };
}
