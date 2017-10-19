//
//  RequestsTests.swift
//  TypetalkSwiftTests
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//

import XCTest
@testable import TypetalkSwift

class RequestsTests: XCTestCase {
  
  func testDeleteFavoriteTopic() {
    let request = DeleteFavoriteTopic(topicId: 1)
    XCTAssertEqual(request.method, .delete)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/favorite")
  }
  
  func testDeleteLike() {
    let request = DeleteLike(topicId: 1, postId: 2)
    XCTAssertEqual(request.method, .delete)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/posts/2/like")
  }
  
  func testDeletePost() {
    let request = DeletePost(topicId: 1, postId: 2)
    XCTAssertEqual(request.method, .delete)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/posts/2")
  }
  
  func testGetAccount() {
    let request = GetAccount(nameOrEmailAddress: "example")
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/search/accounts?nameOrEmailAddress=example")
  }
  
  func testGetAccountProfile() {
    let request = GetAccountProfile(accountName: "example")
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/accounts/profile/example")
  }
  
  func testGetAccountsStatus() {
    let request = GetAccountsStatus(accountIds: [1, 2])
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/accounts/status?accountIds=1&accountIds=2")
  }
  
  func testGetBookmarks() {
    let request = GetBookmarks()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/bookmarks")
  }
  
  func testGetDMPosts() {
    do {
      let request = GetDMPosts(accountName: "example", from: nil, direction: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/messages/@example")
    }
    do {
      let request = GetDMPosts(accountName: "example", from: 10, direction: .forward)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/messages/@example?direction=forward&from=10")
    }
  }
  
  func testGetDMTopics() {
    let request = GetDMTopics()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/messages")
  }
  
  func testGetFriends() {
    do {
      let request = GetFriends(q: "example", offset: nil, count: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v2/search/friends?q=example")
    }
    do {
      let request = GetFriends(q: "example", offset: 20, count: 10)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v2/search/friends?count=10&offset=20&q=example")
    }
  }
  
  func testGetLikesDiscover() {
    do {
      let request = GetLikesDiscover(from: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/likes/discover")
    }
    do {
      let request = GetLikesDiscover(from: 10)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/likes/discover?from=10")
    }
  }
  
  func testGetLikesGiven() {
    do {
      let request = GetLikesGiven(from: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/likes/give")
    }
    do {
      let request = GetLikesGiven(from: 10)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/likes/give?from=10")
    }
  }
  
  func testGetLikesReceived() {
    do {
      let request = GetLikesReceived(from: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/likes/receive")
    }
    do {
      let request = GetLikesReceived(from: 10)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/likes/receive?from=10")
    }
  }
  
  func testGetMentions() {
    do {
      let request = GetMentions(from: nil, unread: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/mentions")
    }
    do {
      let request = GetMentions(from: 10, unread: true)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/mentions?from=10&unread=1")
    }
  }
  
  func testGetNotificationStatus() {
    let request = GetNotificationStatus()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/notifications/status")
  }
  
  func testGetNotifications() {
    let request = GetNotifications()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/notifications")
  }
  
  func testGetPost() {
    let request = GetPost(topicId: 1, postId: 2)
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/posts/2")
  }
  
  func testGetPosts() {
    do {
      let request = GetPosts(topicId: 1, from: nil, direction: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1")
    }
    do {
      let request = GetPosts(topicId: 1, from: 10, direction: .forward)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1?direction=forward&from=10")
    }
  }
  
  func testGetPostsAround() {
    let request = GetPostsAround(topicId: 1, postId: 2)
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/posts/2/around")
  }
  
  func testGetPostsInTalk() {
    do {
      let request = GetPostsInTalk(topicId: 1, talkId: 2, from: nil, direction: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/talks/2/posts")
    }
    do {
      let request = GetPostsInTalk(topicId: 1, talkId: 2, from: 10, direction: .forward)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/talks/2/posts?direction=forward&from=10")
    }
  }
  
  func testGetPostsSearched() {
    do {
      let request = GetPostsSearched(q: "example", topicIds: nil, accountIds: nil, hasAttachments: nil, start: nil, from: nil, to: nil)
      XCTAssertEqual(request.method, .get)
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/search/posts?q=example")
    }
    do {
      let request = GetPostsSearched(q: "example", topicIds: [1, 2], accountIds: [3, 4], hasAttachments: true, start: 10, from: "2017-10-01'T'00:00:00ZZZZ", to: "2017-10-30'T'23:59:59ZZZZ")
      XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/search/posts?accountIds=3&accountIds=4&from=2017-10-01%27T%2700%3A00%3A00ZZZZ&hasAttachments=1&q=example&start=10&to=2017-10-30%27T%2723%3A59%3A59ZZZZ&topicIds=1&topicIds=2")
    }
  }
  
  func testGetProfile() {
    let request = GetProfile()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/profile")
  }
  
  func testGetSpaces() {
    let request = GetSpaces()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/spaces")
  }
  
  func testGetTalks() {
    let request = GetTalks(topicId: 1)
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/talks")
  }
  
  func testGetTeams() {
    let request = GetTeams()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/teams")
  }
  
  func testGetTopic() {
    let request = GetTopic(topicId: 1)
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/details")
  }
  
  func testGetTopicMembersStatuses() {
    let request = GetTopicMembersStatuses(topicId: 1)
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/members/status")
  }
  
  func testGetTopics() {
    let request = GetTopics()
    XCTAssertEqual(request.method, .get)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics")
  }
  
  func testPostAcceptTeamInvitation() {
    let request = PostAcceptTeamInvitation(teamId: 1, inviteId: 2)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/teams/1/members/invite/2/accept")
  }
  
  func testPostAcceptTopicInvitation() {
    let request = PostAcceptTopicInvitation(topicId: 1, inviteId: 2)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/members/invite/2/accept")
  }
  
  func testPostAttachment() {
    let data = Data()
    let request = PostAttachment(topicId: 1, data: data, fileName: "example.png")
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/attachments")
    
    let bodyParameter = request.bodyParameter
    XCTAssertEqual(bodyParameter?.data, data)
    XCTAssertEqual(bodyParameter?.withName, "file")
    XCTAssertEqual(bodyParameter?.fileName, "example.png")
    XCTAssertEqual(bodyParameter?.mimeType, "")
  }
  
  func testPostDMPost() {
    let request = PostDMPost(accountName: "example", message: "example", replyTo: 1, fileKeys: ["2", "3"], talkIds: [4, 5])
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/messages/@example")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["message"] as? String == "example", true)
    XCTAssertEqual(parameters?["replyTo"] as? Int == 1, true)
    XCTAssertEqual(parameters?["fileKeys"] as? [String] ?? [] == ["2", "3"], true)
    XCTAssertEqual(parameters?["talkIds"] as? [Int] ?? [] == [4, 5], true)
  }
  
  func testPostDeclineTeamInvitation() {
    let request = PostDeclineTeamInvitation(teamId: 1, inviteId: 2)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/teams/1/members/invite/2/decline")
  }
  
  func testPostDeclineTopicInvitation() {
    let request = PostDeclineTopicInvitation(topicId: 1, inviteId: 2)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/members/invite/2/decline")
  }
  
  func testPostFavoriteTopic() {
    let request = PostFavoriteTopic(topicId: 1)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/favorite")
  }
  
  func testPostInviteTopicMembers() {
    let request = PostInviteTopicMembers(topicId: 1, inviteMembers: ["example1", "example2"], inviteMessage: "example")
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/members/invite")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["inviteMembers"] as? [String] ?? [] == ["example1", "example2"], true)
    XCTAssertEqual(parameters?["inviteMessage"] as? String == "example", true)
  }
  
  func testPostLike() {
    let request = PostLike(topicId: 1, postId: 2)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/posts/2/like")
  }
  
  func testPostLikeBookmark() {
    let request = PostLikeBookmark(likeId: 1)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/likes/receive/bookmark/save")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["likeId"] as? Int == 1, true)
  }
  
  func testPostMigrateToDMTopic() {
    let request = PostMigrateToDMTopic(accountName: "example", topicId: 1)
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/messages/@example/migrate")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["topicId"] as? Int == 1, true)
  }
  
  func testPostPost() {
    let request = PostPost(topicId: 1, message: "example", replyTo: 2, fileKeys: ["3", "4"], talkIds: [5, 6])
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["message"] as? String == "example", true)
    XCTAssertEqual(parameters?["replyTo"] as? Int == 2, true)
    XCTAssertEqual(parameters?["fileKeys"] as? [String] ?? [] == ["3", "4"], true)
    XCTAssertEqual(parameters?["talkIds"] as? [Int] ?? [] == [5, 6], true)
  }
  
  func testPostRemoveTopicMembers() {
    let request = PostRemoveTopicMembers(topicId: 1, removeInviteIds: [2, 3], removeMemberIds: [4, 5])
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/members/remove")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["removeInviteIds"] as? [Int] ?? [] == [2, 3], true)
    XCTAssertEqual(parameters?["removeMemberIds"] as? [Int] ?? [] == [4, 5], true)
  }
  
  func testPostTopicPostRemoveTopicMembers() {
    let request = PostTopic(name: "example", spaceKey: "ABCDEFG", addAccountIds: [1, 2], addGroupIds: [3, 4])
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["name"] as? String == "example", true)
    XCTAssertEqual(parameters?["spaceKey"] as? String == "ABCDEFG", true)
    XCTAssertEqual(parameters?["addAccountIds"] as? [Int] ?? [] == [1, 2], true)
    XCTAssertEqual(parameters?["addGroupIds"] as? [Int] ?? [] == [3, 4], true)
  }
  
  func testPostUpdateTopicMembers() {
    let request = PostUpdateTopicMembers(topicId: 1, addAccountIds: [1, 2], addGroupIds: [3, 4], removeAccountIds: [5, 6], removeGroupIds: [7, 8])
    XCTAssertEqual(request.method, .post)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/members/update")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["addAccountIds"] as? [Int] ?? [] == [1, 2], true)
    XCTAssertEqual(parameters?["addGroupIds"] as? [Int] ?? [] == [3, 4], true)
    XCTAssertEqual(parameters?["removeAccountIds"] as? [Int] ?? [] == [5, 6], true)
    XCTAssertEqual(parameters?["removeGroupIds"] as? [Int] ?? [] == [7, 8], true)
  }
  
  func testPutBookmarks() {
    let request = PutBookmarks(topicId: 1, postId: 2)
    XCTAssertEqual(request.method, .put)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/bookmarks")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["topicId"] as? Int == 1, true)
    XCTAssertEqual(parameters?["postId"] as? Int == 2, true)
  }
  
  func testPutMentions() {
    let request = PutMentions(mentionId: 1)
    XCTAssertEqual(request.method, .put)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/mentions/1")
  }
  
  func testPutNotifications() {
    let request = PutNotifications()
    XCTAssertEqual(request.method, .put)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/notifications")
  }
  
  func testPutPost() {
    let request = PutPost(topicId: 1, postId: 2, message: "example")
    XCTAssertEqual(request.method, .put)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1/posts/2")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["message"] as? String == "example", true)
  }
  
  func testPutTopic() {
    let request = PutTopic(topicId: 1, name: "example1", description: "example2", teamId: 2)
    XCTAssertEqual(request.method, .put)
    XCTAssertEqual((try? request.asURLRequest(""))?.url?.absoluteString, "/api/v1/topics/1")
    
    let parameters = request.parameters
    XCTAssertEqual(parameters?["name"] as? String == "example1", true)
    XCTAssertEqual(parameters?["description"] as? String == "example2", true)
    XCTAssertEqual(parameters?["teamId"] as? Int == 2, true)
  }
}
