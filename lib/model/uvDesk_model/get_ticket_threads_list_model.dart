// To parse this JSON data, do
//
//     final threadsListModel = threadsListModelFromJson(jsonString);

import 'dart:convert';

ThreadsListModel threadsListModelFromJson(String str) => ThreadsListModel.fromJson(json.decode(str));

String threadsListModelToJson(ThreadsListModel data) => json.encode(data.toJson());

class ThreadsListModel {
  Ticket ticket;
  int totalCustomerTickets;
  List<SupportGroup> supportGroups;
  List<dynamic> supportTeams;
  List<TicketPriorityElement> ticketStatuses;
  List<TicketPriorityElement> ticketPriorities;
  List<TicketPriorityElement> ticketTypes;

  ThreadsListModel({
    required this.ticket,
    required this.totalCustomerTickets,
    required this.supportGroups,
    required this.supportTeams,
    required this.ticketStatuses,
    required this.ticketPriorities,
    required this.ticketTypes,
  });

  factory ThreadsListModel.fromJson(Map<String, dynamic> json) => ThreadsListModel(
    ticket: Ticket.fromJson(json["ticket"]),
    totalCustomerTickets: json["totalCustomerTickets"],
    supportGroups: List<SupportGroup>.from(json["supportGroups"].map((x) => SupportGroup.fromJson(x))),
    supportTeams: List<dynamic>.from(json["supportTeams"].map((x) => x)),
    ticketStatuses: List<TicketPriorityElement>.from(json["ticketStatuses"].map((x) => TicketPriorityElement.fromJson(x))),
    ticketPriorities: List<TicketPriorityElement>.from(json["ticketPriorities"].map((x) => TicketPriorityElement.fromJson(x))),
    ticketTypes: List<TicketPriorityElement>.from(json["ticketTypes"].map((x) => TicketPriorityElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ticket": ticket.toJson(),
    "totalCustomerTickets": totalCustomerTickets,
    "supportGroups": List<dynamic>.from(supportGroups.map((x) => x.toJson())),
    "supportTeams": List<dynamic>.from(supportTeams.map((x) => x)),
    "ticketStatuses": List<dynamic>.from(ticketStatuses.map((x) => x.toJson())),
    "ticketPriorities": List<dynamic>.from(ticketPriorities.map((x) => x.toJson())),
    "ticketTypes": List<dynamic>.from(ticketTypes.map((x) => x.toJson())),
  };
}

class SupportGroup {
  int id;
  String name;

  SupportGroup({
    required this.id,
    required this.name,
  });

  factory SupportGroup.fromJson(Map<String, dynamic> json) => SupportGroup(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Ticket {
  int id;
  String source;
  int priority;
  int status;
  String subject;
  bool isNew;
  bool isReplied;
  bool isReplyEnabled;
  bool isStarred;
  bool isTrashed;
  bool isAgentViewed;
  bool isCustomerViewed;
  String createdAt;
  String updatedAt;
  dynamic group;
  dynamic team;
  List<Thread> threads;
  Agent agent;
  Agent customer;
  int totalThreads;

  Ticket({
    required this.id,
    required this.source,
    required this.priority,
    required this.status,
    required this.subject,
    required this.isNew,
    required this.isReplied,
    required this.isReplyEnabled,
    required this.isStarred,
    required this.isTrashed,
    required this.isAgentViewed,
    required this.isCustomerViewed,
    required this.createdAt,
    required this.updatedAt,
    this.group,
    this.team,
    required this.threads,
    required this.agent,
    required this.customer,
    required this.totalThreads,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    source: json["source"],
    priority: json["priority"],
    status: json["status"],
    subject: json["subject"],
    isNew: json["isNew"],
    isReplied: json["isReplied"],
    isReplyEnabled: json["isReplyEnabled"],
    isStarred: json["isStarred"],
    isTrashed: json["isTrashed"],
    isAgentViewed: json["isAgentViewed"],
    isCustomerViewed: json["isCustomerViewed"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    group: json["group"],
    team: json["team"],
    threads: List<Thread>.from(json["threads"].map((x) => Thread.fromJson(x))),
    agent: Agent.fromJson(json["agent"]),
    customer: Agent.fromJson(json["customer"]),
    totalThreads: json["totalThreads"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "source": source,
    "priority": priority,
    "status": status,
    "subject": subject,
    "isNew": isNew,
    "isReplied": isReplied,
    "isReplyEnabled": isReplyEnabled,
    "isStarred": isStarred,
    "isTrashed": isTrashed,
    "isAgentViewed": isAgentViewed,
    "isCustomerViewed": isCustomerViewed,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "group": group,
    "team": team,
    "threads": List<dynamic>.from(threads.map((x) => x.toJson())),
    "agent": agent.toJson(),
    "customer": customer.toJson(),
    "totalThreads": totalThreads,
  };
}

class Agent {
  int id;
  String email;
  String name;
  String firstName;
  String lastName;
  dynamic contactNumber;
  String thumbnail;

  Agent({
    required this.id,
    required this.email,
    required this.name,
    required this.firstName,
    required this.lastName,
    this.contactNumber,
    required this.thumbnail,
  });

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    contactNumber: json["contactNumber"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "firstName": firstName,
    "lastName": lastName,
    "contactNumber": contactNumber,
    "thumbnail": thumbnail,
  };
}

class Thread {
  int id;
  String source;
  String threadType;
  String createdBy;
  dynamic cc;
  dynamic bcc;
  bool isLocked;
  bool isBookmarked;
  String message;
  String createdAt;
  String updatedAt;
  User user;
  List<dynamic> attachments;

  Thread({
    required this.id,
    required this.source,
    required this.threadType,
    required this.createdBy,
    this.cc,
    this.bcc,
    required this.isLocked,
    required this.isBookmarked,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.attachments,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
    id: json["id"],
    source: json["source"],
    threadType: json["threadType"],
    createdBy: json["createdBy"],
    cc: json["cc"],
    bcc: json["bcc"],
    isLocked: json["isLocked"],
    isBookmarked: json["isBookmarked"],
    message: json["message"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    user: User.fromJson(json["user"]),
    attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "source": source,
    "threadType": threadType,
    "createdBy": createdBy,
    "cc": cc,
    "bcc": bcc,
    "isLocked": isLocked,
    "isBookmarked": isBookmarked,
    "message": message,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "user": user.toJson(),
    "attachments": List<dynamic>.from(attachments.map((x) => x)),
  };
}

class User {
  String id;
  String name;
  String email;
  String thumbnail;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.thumbnail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"].toString(),
    name: json["name"],
    email: json["email"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "thumbnail": thumbnail,
  };
}

class TicketPriorityElement {
  int id;
  String code;
  String? colorCode;
  String description;
  bool? isActive;

  TicketPriorityElement({
    required this.id,
    required this.code,
    this.colorCode,
    required this.description,
    this.isActive,
  });

  factory TicketPriorityElement.fromJson(Map<String, dynamic> json) => TicketPriorityElement(
    id: json["id"],
    code: json["code"],
    colorCode: json["colorCode"],
    description: json["description"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "colorCode": colorCode,
    "description": description,
    "isActive": isActive,
  };
}


// class ThreadsListModel {
//   List<Thread> threads;
//   Pagination? pagination;
//
//   ThreadsListModel({
//     required this.threads,
//     this.pagination,
//   });
//
//   factory ThreadsListModel.fromJson(Map<String, dynamic> json) =>
//       ThreadsListModel(
//         threads:
//         List<Thread>.from(json["threads"].map((x) => Thread.fromJson(x))),
//         pagination: Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "threads": List<dynamic>.from(threads.map((x) => x.toJson())),
//     "pagination": pagination?.toJson(),
//   };
// }

class Pagination {
  int? last;
  int? current;
  int? numItemsPerPage;
  int? first;
  int? pageCount;
  int? totalCount;
  int? pageRange;
  int? startPage;
  int? endPage;
  List<int>? pagesInRange;
  int? firstPageInRange;
  int? lastPageInRange;
  int? currentItemCount;
  int? firstItemNumber;
  int? lastItemNumber;
  String? url;

  Pagination({
    this.last,
    this.current,
    this.numItemsPerPage,
    this.first,
    this.pageCount,
    this.totalCount,
    this.pageRange,
    this.startPage,
    this.endPage,
    this.pagesInRange,
    this.firstPageInRange,
    this.lastPageInRange,
    this.currentItemCount,
    this.firstItemNumber,
    this.lastItemNumber,
    this.url,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    last: json["last"],
    current: json["current"],
    numItemsPerPage: json["numItemsPerPage"],
    first: json["first"],
    pageCount: json["pageCount"],
    totalCount: json["totalCount"],
    pageRange: json["pageRange"],
    startPage: json["startPage"],
    endPage: json["endPage"],
    pagesInRange: List<int>.from(json["pagesInRange"].map((x) => x)),
    firstPageInRange: json["firstPageInRange"],
    lastPageInRange: json["lastPageInRange"],
    currentItemCount: json["currentItemCount"],
    firstItemNumber: json["firstItemNumber"],
    lastItemNumber: json["lastItemNumber"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "last": last,
    "current": current,
    "numItemsPerPage": numItemsPerPage,
    "first": first,
    "pageCount": pageCount,
    "totalCount": totalCount,
    "pageRange": pageRange,
    "startPage": startPage,
    "endPage": endPage,
    "pagesInRange": List<dynamic>.from(pagesInRange!.map((x) => x)),
    "firstPageInRange": firstPageInRange,
    "lastPageInRange": lastPageInRange,
    "currentItemCount": currentItemCount,
    "firstItemNumber": firstItemNumber,
    "lastItemNumber": lastItemNumber,
    "url": url,
  };
}

// class Thread {
//   int? id;
//   String? reply;
//   String? source;
//   String? threadType;
//   List<dynamic>? replyTo;
//   List<dynamic>? cc;
//   List<dynamic>? bcc;
//   String? userType;
//   CreatedAt? createdAt;
//   String? formatedCreatedAt;
//   String? messageId;
//   User? user;
//   List<dynamic>? attachments;
//   bool? isLocked;
//   String? fullname;
//   String? bookmark;
//   String? viewedAt;
//   String? mailStatus;
//   String? task;
//
//   Thread({
//     this.id,
//     this.reply,
//     this.source,
//     this.threadType,
//     this.replyTo,
//     this.cc,
//     this.bcc,
//     this.userType,
//     this.createdAt,
//     this.formatedCreatedAt,
//     this.messageId,
//     this.user,
//     this.attachments,
//     this.isLocked,
//     this.fullname,
//     this.bookmark,
//     this.viewedAt,
//     this.mailStatus,
//     this.task,
//   });
//
//   factory Thread.fromJson(Map<String, dynamic> json) => Thread(
//     id: json["id"],
//     reply: json["reply"],
//     source: json["source"],
//     threadType: json["threadType"],
//     replyTo: json["replyTo"] != null
//         ? List<dynamic>.from(json["replyTo"].map((x) => x))
//         : null,
//     cc: json["cc"] != null
//         ? List<dynamic>.from(json["cc"].map((x) => x))
//         : null,
//     bcc: json["bcc"] != null
//         ? List<dynamic>.from(json["bcc"].map((x) => x))
//         : null,
//     userType: json["userType"],
//     createdAt: CreatedAt.fromJson(json["createdAt"]),
//     formatedCreatedAt: json["formatedCreatedAt"],
//     messageId: json["messageId"],
//     user: User.fromJson(json["user"]),
//     attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
//     isLocked: json["isLocked"],
//     fullname: json["fullname"],
//     bookmark: json["bookmark"],
//     viewedAt: json["viewedAt"],
//     mailStatus: json["mailStatus"],
//     task: json["task"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "reply": reply,
//     "source": source,
//     "threadType": threadType,
//     "replyTo": List<dynamic>.from(replyTo!.map((x) => x)),
//     "cc": List<dynamic>.from(cc!.map((x) => x)),
//     "bcc": List<dynamic>.from(bcc!.map((x) => x)),
//     "userType": userType,
//     "createdAt": createdAt?.toJson(),
//     "formatedCreatedAt": formatedCreatedAt,
//     "messageId": messageId,
//     "user": user?.toJson(),
//     "attachments": List<dynamic>.from(attachments!.map((x) => x)),
//     "isLocked": isLocked,
//     "fullname": fullname,
//     "bookmark": bookmark,
//     "viewedAt": viewedAt,
//     "mailStatus": mailStatus,
//     "task": task,
//   };
// }

class CreatedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreatedAt({
    this.timezone,
    this.offset,
    this.timestamp,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
    timezone: Timezone.fromJson(json["timezone"]),
    offset: json["offset"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "timezone": timezone?.toJson(),
    "offset": offset,
    "timestamp": timestamp,
  };
}

class Timezone {
  String? name;
  Location? location;

  Timezone({
    this.name,
    this.location,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
    name: json["name"],
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "location": location?.toJson(),
  };
}

class Location {
  String? countryCode;
  int? latitude;
  int? longitude;
  String? comments;

  Location({
    this.countryCode,
    this.latitude,
    this.longitude,
    this.comments,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    countryCode: json["country_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    comments: json["comments"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "latitude": latitude,
    "longitude": longitude,
    "comments": comments,
  };
}

// class User {
//   int? id;
//   String? email;
//   String? smallThumbnail;
//   bool? isActive;
//   bool? enabled;
//   CurrentUserAgentInstance? currentUserInstance;
//   CurrentUserAgentInstance? currentUserAgentInstance;
//   String? currentUserCustomerInstance;
//   String? role;
//   Detail? detail;
//   String? timezone;
//
//   User({
//     this.id,
//     this.email,
//     this.smallThumbnail,
//     this.isActive,
//     this.enabled,
//     this.currentUserInstance,
//     this.currentUserAgentInstance,
//     this.currentUserCustomerInstance,
//     this.role,
//     this.detail,
//     this.timezone,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     email: json["email"],
//     smallThumbnail: json["smallThumbnail"],
//     isActive: json["isActive"],
//     enabled: json["enabled"],
//     currentUserInstance: json["currentUserInstance"] == null
//         ? null
//         : CurrentUserAgentInstance.fromJson(json["currentUserInstance"]),
//     currentUserAgentInstance: json["currentUserAgentInstance"] == null
//         ? null
//         : CurrentUserAgentInstance.fromJson(
//         json["currentUserAgentInstance"]),
//     currentUserCustomerInstance: json["currentUserCustomerInstance"],
//     role: json["role"],
//     detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
//     timezone: json["timezone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "email": email,
//     "smallThumbnail": smallThumbnail,
//     "isActive": isActive,
//     "enabled": enabled,
//     "currentUserInstance": currentUserInstance?.toJson(),
//     "currentUserAgentInstance": currentUserAgentInstance?.toJson(),
//     "currentUserCustomerInstance": currentUserCustomerInstance,
//     "role": role,
//     "detail": detail?.toJson(),
//     "timezone": timezone,
//   };
// }

class CurrentUserAgentInstance {
  int? id;
  int? companyId;
  UserRole? userRole;
  String? firstName;
  String? lastName;
  String? name;
  CreatedAt? createdAt;
  bool? isActive;
  String? isStarred;
  int? user;
  String? signature;
  int? ticketView;
  bool? isVerified;
  String? source;
  List<dynamic>? authorisedClients;
  String? activityNotifications;
  String? assignedTeamIdReferences;
  String? assignedGroupIdReferences;
  bool? forceLogout;

  CurrentUserAgentInstance({
    this.id,
    this.companyId,
    this.userRole,
    this.firstName,
    this.lastName,
    this.name,
    this.createdAt,
    this.isActive,
    this.isStarred,
    this.user,
    this.signature,
    this.ticketView,
    this.isVerified,
    this.source,
    this.authorisedClients,
    this.activityNotifications,
    this.assignedTeamIdReferences,
    this.assignedGroupIdReferences,
    this.forceLogout,
  });

  factory CurrentUserAgentInstance.fromJson(Map<String, dynamic> json) =>
      CurrentUserAgentInstance(
        id: json["id"],
        companyId: json["companyId"],
        userRole: UserRole.fromJson(json["userRole"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        name: json["name"],
        createdAt: CreatedAt.fromJson(json["createdAt"]),
        isActive: json["isActive"],
        isStarred: json["isStarred"],
        user: json["user"],
        signature: json["signature"],
        ticketView: json["ticketView"],
        isVerified: json["isVerified"],
        source: json["source"],
        authorisedClients:
        List<dynamic>.from(json["authorisedClients"].map((x) => x)),
        activityNotifications: json["activityNotifications"],
        assignedTeamIdReferences: json["assignedTeamIdReferences"],
        assignedGroupIdReferences: json["assignedGroupIdReferences"],
        forceLogout: json["forceLogout"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyId": companyId,
    "userRole": userRole?.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "name": name,
    "createdAt": createdAt?.toJson(),
    "isActive": isActive,
    "isStarred": isStarred,
    "user": user,
    "signature": signature,
    "ticketView": ticketView,
    "isVerified": isVerified,
    "source": source,
    "authorisedClients":
    List<dynamic>.from(authorisedClients!.map((x) => x)),
    "activityNotifications": activityNotifications,
    "assignedTeamIdReferences": assignedTeamIdReferences,
    "assignedGroupIdReferences": assignedGroupIdReferences,
    "forceLogout": forceLogout,
  };
}

class UserRole {
  int? id;
  String? role;
  String? name;

  UserRole({
    this.id,
    this.role,
    this.name,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
    id: json["id"],
    role: json["role"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "name": name,
  };
}

class Detail {
  CurrentUserAgentInstance? agent;

  Detail({
    this.agent,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    agent: CurrentUserAgentInstance.fromJson(json["agent"]),
  );

  Map<String, dynamic> toJson() => {
    "agent": agent?.toJson(),
  };
}
