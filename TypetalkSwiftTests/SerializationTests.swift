//
//  TypetalkSwiftTests.swift
//  TypetalkSwiftTests
//
//  Created by Taichiro Yoshida on 2017/10/15.
//  Copyright © 2017 Nulab Inc. All rights reserved.
//


import XCTest
import OHHTTPStubs
@testable import TypetalkSwift

class TypetalkSwiftTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
    Client.setAPISettings(
      clientId: "",
      clientSecret: "",
      scopes: [.all],
      redirectUri: "",
      authorizeContext: self)
    Client.shared.oauth2.accessToken = "Dummy Access Token for Test"
    Client.shared.oauth2.useKeychain = false
  }
  
  func withStub(name: String, status: Int32 = 200) {
    stub(condition: { _ in return true }) { _ in
      let stubPath = OHPathForFile("\(name).json", type(of: self))
      return fixture(filePath: stubPath!, status: status, headers: ["Content-Type":"application/json"])
    }
  }
  
  func testGetProfile() {
    withStub(name: "get-profile")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetProfile()) { (result) -> Void in
      switch result {
      case .success(let value):
        let account = value.account
        XCTAssertEqual(account.id, 100)
        XCTAssertEqual(account.name, "jessica")
        XCTAssertEqual(account.fullName, "Jessica Fitzherbert")
        XCTAssertEqual(account.suggestion, "Jessica Fitzherbert")
        XCTAssertEqual(account.imageUrl, URL(string: "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000"))
        XCTAssertEqual(account.createdAt, ISO8601DateFormatter().date(from: "2014-06-24T02:32:29Z"))
        XCTAssertEqual(account.updatedAt, ISO8601DateFormatter().date(from: "2014-06-24T02:32:29Z"))
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetTopics() {
    withStub(name: "get-topics")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetTopics()) { (result) -> Void in
      switch result {
      case .success(let value):
        let topicWithInfos = value.topics
        XCTAssertEqual(topicWithInfos.count, 9)
        let topicWithInfo = topicWithInfos[0]
        
        let topic = topicWithInfo.topic
        XCTAssertEqual(topic.id, 208)
        XCTAssertEqual(topic.name, "IT Peeps")
        XCTAssertEqual(topic.description, "")
        XCTAssertEqual(topic.suggestion, "IT Peeps")
        XCTAssertEqual(topic.isDirectMessage, false)
        XCTAssertEqual(topic.lastPostedAt, ISO8601DateFormatter().date(from: "2014-07-01T02:32:29Z"))
        XCTAssertEqual(topic.createdAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        XCTAssertEqual(topic.updatedAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        
        XCTAssertEqual(topicWithInfo.favorite, true)
        
        let unread = topicWithInfo.unread
        XCTAssertEqual(unread.topicId, 208)
        XCTAssertEqual(unread.postId, 304)
        XCTAssertEqual(unread.count, 3)
        XCTAssertEqual(unread.isOverCountLimit, false)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetDMTopics() {
    withStub(name: "get-dm-topics")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetDMTopics()) { (result) -> Void in
      switch result {
      case .success(let value):
        let dmTopicWithInfos = value.topics
        XCTAssertEqual(dmTopicWithInfos.count, 5)
        let dmTopicWithInfo = dmTopicWithInfos[0]
        
        let topic = dmTopicWithInfo.topic
        XCTAssertEqual(topic.id, 214)
        XCTAssertEqual(topic.name, "jessica,stefhull")
        XCTAssertEqual(topic.description, "")
        XCTAssertEqual(topic.suggestion, "jessica,stefhull")
        XCTAssertEqual(topic.isDirectMessage, true)
        XCTAssertEqual(topic.lastPostedAt, ISO8601DateFormatter().date(from: "2014-06-12T04:32:29Z"))
        XCTAssertEqual(topic.createdAt, ISO8601DateFormatter().date(from: "2014-06-12T03:32:29Z"))
        XCTAssertEqual(topic.updatedAt, ISO8601DateFormatter().date(from: "2014-06-12T03:32:29Z"))
        
        let unread = dmTopicWithInfo.unread
        XCTAssertEqual(unread.topicId, 214)
        XCTAssertEqual(unread.postId, 0)
        XCTAssertEqual(unread.count, 0)
        XCTAssertEqual(unread.isOverCountLimit, false)
        
        let directMessage = dmTopicWithInfo.directMessage
        
        let account = directMessage.account
        XCTAssertEqual(account.id, 103)
        XCTAssertEqual(account.name, "stefhull")
        XCTAssertEqual(account.fullName, "StefHull")
        XCTAssertEqual(account.suggestion, "StefHull")
        XCTAssertEqual(account.imageUrl, URL(string: "https://typetalk.com/accounts/103/profile_image.png?t=1403836349000"))
        XCTAssertEqual(account.isBot, false)
        XCTAssertEqual(account.createdAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
        XCTAssertEqual(account.updatedAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
        
        let status = directMessage.status
        XCTAssertEqual(status.presence, .away)
        XCTAssertEqual(status.web == nil, true)
        XCTAssertEqual(status.mobile == nil, true)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetPosts() {
    withStub(name: "get-messages")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetPosts(topicId: 1, from: nil, direction: nil)) { (result) -> Void in
      switch result {
      case .success(let postsNormal):
        let mySpace = postsNormal.mySpace
        
        let space = mySpace?.space
        XCTAssertEqual(space?.key, "abcdefghij")
        XCTAssertEqual(space?.name, "Joe Tech Inc.")
        XCTAssertEqual(space?.enabled, true)
        XCTAssertEqual(space?.imageUrl, URL(string: "http://nulabapps.local:18080/nulab-account-web/spaces/abcdefghij/photo/large"))
        
        XCTAssertEqual(mySpace?.myRole, .ADMIN)
        XCTAssertEqual(mySpace?.isPaymentAdmin, true)
        XCTAssertEqual(mySpace?.invitableRoles?.contains(.ADMIN), false)
        XCTAssertEqual(mySpace?.invitableRoles?.contains(.USER), true)
        XCTAssertEqual(mySpace?.invitableRoles?.contains(.GUEST), true)
        
        let myPlan = mySpace?.myPlan
        let plan = myPlan?.plan
        XCTAssertEqual(plan?.key, "typetalk.free")
        XCTAssertEqual(plan?.name, "Free Plan")
        XCTAssertEqual(plan?.limitNumberOfUsers, 10)
        XCTAssertEqual(plan?.limitTotalAttachmentSize, 1073741824)
        
        XCTAssertEqual(myPlan?.enabled, true)
        
        let trial = myPlan?.trial
        XCTAssertEqual(trial?.endDate, ISO8601DateFormatter().date(from: "2016-01-10T02:32:29Z"))
        XCTAssertEqual(trial?.daysLeft, 10)
        
        XCTAssertEqual(myPlan?.numberOfUsers, 7)
        XCTAssertEqual(myPlan?.totalAttachmentSize, 0)
        XCTAssertEqual(myPlan?.createdAt, ISO8601DateFormatter().date(from: "2016-01-10T02:32:29Z"))
        XCTAssertEqual(myPlan?.updatedAt, ISO8601DateFormatter().date(from: "2016-01-20T02:32:29Z"))
        
        XCTAssertEqual(postsNormal.team == nil, true)
        
        let topic = postsNormal.topic
        XCTAssertEqual(topic.id, 208)
        XCTAssertEqual(topic.name, "IT Peeps")
        XCTAssertEqual(topic.description, "")
        XCTAssertEqual(topic.suggestion, "IT Peeps")
        XCTAssertEqual(topic.isDirectMessage, false)
        XCTAssertEqual(topic.lastPostedAt, ISO8601DateFormatter().date(from: "2014-07-01T02:32:29Z"))
        XCTAssertEqual(topic.createdAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        XCTAssertEqual(topic.updatedAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        
        let bookmark = postsNormal.bookmark
        XCTAssertEqual(bookmark?.postId, 304)
        XCTAssertEqual(bookmark?.updatedAt, ISO8601DateFormatter().date(from: "2016-12-21T01:11:42Z"))
        
        XCTAssertEqual(postsNormal.posts.count, 8)
        
        do {
          let post = postsNormal.posts[0]
          XCTAssertEqual(post.id, 300)
          XCTAssertEqual(post.topicId, 208)
          XCTAssertEqual(post.replyTo, 298)
          XCTAssertEqual(post.message, "Here's an example of a link, images and slide. http://nulab-inc.com https://speakerdeck.com/nulabinc/nulabs-way-of-working-remotely")
          
          let account = post.account
          XCTAssertEqual(account.id, 103)
          XCTAssertEqual(account.name, "stefhull")
          XCTAssertEqual(account.fullName, "StefHull")
          XCTAssertEqual(account.suggestion, "StefHull")
          XCTAssertEqual(account.imageUrl, URL(string: "https://typetalk.com/accounts/103/profile_image.png?t=1403836349000"))
          XCTAssertEqual(account.isBot, false)
          XCTAssertEqual(account.createdAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
          XCTAssertEqual(account.updatedAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
          
          let mention = post.mention
          XCTAssertEqual(mention?.id, 500)
          XCTAssertEqual(mention?.readAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
          
          XCTAssertEqual(post.attachments.count, 4)
          
          let attachmentWithInfo = post.attachments[0]
          let attachment = attachmentWithInfo.attachment
          XCTAssertEqual(attachment.contentType, "image/jpeg")
          XCTAssertEqual(attachment.fileKey, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
          XCTAssertEqual(attachment.fileName, "1.jpg")
          XCTAssertEqual(attachment.fileSize, 472263)
          
          XCTAssertEqual(attachmentWithInfo.webUrl, URL(string: "https://typetalk.com/topics/208/posts/300/attachments/1/1.jpg"))
          XCTAssertEqual(attachmentWithInfo.apiUrl, URL(string: "https://typetalk.com/api/v1/topics/208/posts/300/attachments/1/1.jpg"))
          
          XCTAssertEqual(attachmentWithInfo.thumbnails?.count, 3)
          
          let thumbnail = attachmentWithInfo.thumbnails?[0]
          XCTAssertEqual(thumbnail?.type, "small")
          XCTAssertEqual(thumbnail?.fileSize, 16842)
          XCTAssertEqual(thumbnail?.width, 480)
          XCTAssertEqual(thumbnail?.height, 360)
          
          XCTAssertEqual(post.links.count, 2)
          
          let link = post.links[0]
          XCTAssertEqual(link.id, 7)
          XCTAssertEqual(link.url, URL(string: "http://nulab-inc.com"))
          XCTAssertEqual(link.contentType, "text/html; charset=UTF-8")
          XCTAssertEqual(link.title, "Fun. Creative. Collaboration. | Nulab Inc.")
          XCTAssertEqual(link.description, "We develop collaborative software tools aimed at facilitating effective work communication and collaboration.")
          XCTAssertEqual(link.imageUrl, URL(string: "http://nulab-inc.com/ogp_dft.png"))
          XCTAssertEqual(link.createdAt, ISO8601DateFormatter().date(from: "2016-12-21T01:11:42Z"))
          XCTAssertEqual(link.updatedAt, ISO8601DateFormatter().date(from: "2016-12-21T01:11:42Z"))
          
          XCTAssertEqual(post.createdAt, ISO8601DateFormatter().date(from: "2014-06-29T00:32:29Z"))
          XCTAssertEqual(post.updatedAt, ISO8601DateFormatter().date(from: "2014-06-29T00:32:29Z"))
        }
        
        do {
          let post = postsNormal.posts[2]
          
          XCTAssertEqual(post.likes.count, 3)
          
          let like = post.likes[0]
          XCTAssertEqual(like.id, 400)
          XCTAssertEqual(like.postId, 302)
          XCTAssertEqual(like.topicId, 208)
          XCTAssertEqual(like.comment, "")
          
          let account = like.account
          XCTAssertEqual(account.id, 100)
          XCTAssertEqual(account.name, "jessica")
          XCTAssertEqual(account.fullName, "Jessica Fitzherbert")
          XCTAssertEqual(account.suggestion, "Jessica Fitzherbert")
          XCTAssertEqual(account.imageUrl, URL(string: "https://typetalk.com/accounts/100/profile_image.png?t=1403577149000"))
          XCTAssertEqual(account.isBot, false)
          XCTAssertEqual(account.createdAt, ISO8601DateFormatter().date(from: "2014-06-24T02:32:29Z"))
          XCTAssertEqual(account.updatedAt, ISO8601DateFormatter().date(from: "2014-06-24T02:32:29Z"))
          
          XCTAssertEqual(like.createdAt, ISO8601DateFormatter().date(from: "2016-12-21T01:11:42Z"))
        }
        
        do {
          let post = postsNormal.posts[5]
          
          XCTAssertEqual(post.talks.count, 2)
          
          let talk = post.talks[0]
          XCTAssertEqual(talk.id, 901)
          XCTAssertEqual(talk.topicId, 208)
          XCTAssertEqual(talk.name, "2nd talk")
          XCTAssertEqual(talk.suggestion, "2nd talk")
          XCTAssertEqual(talk.createdAt, ISO8601DateFormatter().date(from: "2014-07-02T03:52:29Z"))
          XCTAssertEqual(talk.updatedAt, ISO8601DateFormatter().date(from: "2014-07-02T03:55:29Z"))
          
          let backlog = talk.backlog
          XCTAssertEqual(backlog?.spaceUrl, URL(string: "https://example.backlog.com"))
          XCTAssertEqual(backlog?.issueKey, "EXAMPLE-9999")
        }
        
        XCTAssertEqual(postsNormal.hasNext, false)
        XCTAssertEqual(postsNormal.exceedsAttachmentLimit, false)
        
        let onboarding = postsNormal.onboarding
        XCTAssertEqual(onboarding?.status, .pending)
        XCTAssertEqual(onboarding?.inviteTopicId, 305)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetPostsAround() {
    withStub(name: "get-around-messages")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetPostsAround(topicId: 1, postId: 1)) { (result) -> Void in
      switch result {
      case .success(let postsAround):
        XCTAssertEqual(postsAround.directMessage == nil, false)
        XCTAssertEqual(postsAround.replies.count, 2)
        XCTAssertEqual(postsAround.hasPrev, true)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetPostsSearched() {
    withStub(name: "get-searched-messages")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetPostsSearched(q: "", topicIds: nil, accountIds: nil, hasAttachments: nil, start: nil, from: "", to: "")) { (result) -> Void in
      switch result {
      case .success(let postsSearched):
        XCTAssertEqual(postsSearched.count, 98)
        XCTAssertEqual(postsSearched.posts.count, 2)
        XCTAssertEqual(postsSearched.isLimited, false)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetDMPosts() {
    withStub(name: "get-direct-messages")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetDMPosts(accountName: "", from: nil, direction: nil)) { (result) -> Void in
      switch result {
      case .success(let dmPosts):
        XCTAssertEqual(dmPosts.posts.count, 8)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostMigrateToDMTopic() {
    withStub(name: "post-migrate-to-dm-topic")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostMigrateToDMTopic(accountName: "", topicId: 1)) { (result) -> Void in
      switch result {
      case .success(let topic):
        XCTAssertEqual(topic.isDirectMessage, true)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostFavoriteTopic() {
    withStub(name: "post-favorite-topic")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostFavoriteTopic(topicId: 1)) { (result) -> Void in
      switch result {
      case .success(let topicWithFavorite):
        XCTAssertEqual(topicWithFavorite.favorite, true)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testDeleteFavoriteTopic() {
    withStub(name: "delete-favorite-topic")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(DeleteFavoriteTopic(topicId: 1)) { (result) -> Void in
      switch result {
      case .success(let topicWithFavorite):
        XCTAssertEqual(topicWithFavorite.favorite, false)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testCreateTopic() {
    withStub(name: "create-topic")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostTopic(name: "", spaceKey: nil, addAccountIds: nil, addGroupIds: nil)) { (result) -> Void in
      switch result {
      case .success(let topicWithDetail):
        XCTAssertEqual(topicWithDetail.groups.count, 1)
        
        let groupWithInfo = topicWithDetail.groups[0]
        let group = groupWithInfo.group
        XCTAssertEqual(group.id, 1100)
        XCTAssertEqual(group.key, "groupkey01")
        XCTAssertEqual(group.name, "Joe Tech Inc. All")
        XCTAssertEqual(group.suggestion, "Joe Tech Inc. All")
        XCTAssertEqual(group.imageUrl, URL(string: "http://nulabapps.local:18080/nulab-account-web/spaces/abcdefghij/groups/groupkey01/photo/medium"))
        XCTAssertEqual(group.createdAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        XCTAssertEqual(group.updatedAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        
        XCTAssertEqual(groupWithInfo.memberCount, 4)
        
        XCTAssertEqual(topicWithDetail.invitingAccounts.count, 1)
        
        let invitingAccount = topicWithDetail.invitingAccounts[0]
        XCTAssertEqual(invitingAccount.spaceRole, .USER)
        
        XCTAssertEqual(topicWithDetail.invites.count, 1)
        
        let invite = topicWithDetail.invites[0]
        XCTAssertEqual(invite.id, 203)
        XCTAssertEqual(invite.account == nil, true)
        XCTAssertEqual(invite.mailAddress, "example@example.com")
        XCTAssertEqual(invite.status, "invite")
        
        let accountsForApi = topicWithDetail.accountsForApi[0]
        XCTAssertEqual(accountsForApi.id, 304)
        XCTAssertEqual(accountsForApi.name, "bot")
        XCTAssertEqual(accountsForApi.fullName, "Bot")
        XCTAssertEqual(accountsForApi.imageUrl, URL(string: "https://typetalk.com/accounts/304/profile_image.png?t=1404095549000"))
        XCTAssertEqual(accountsForApi.isBot, true)
        XCTAssertEqual(accountsForApi.owner == nil, true)
        XCTAssertEqual(accountsForApi.createdAt, ISO8601DateFormatter().date(from: "2014-06-30T02:32:29Z"))
        XCTAssertEqual(accountsForApi.updatedAt, ISO8601DateFormatter().date(from: "2014-06-30T02:32:29Z"))
        
        XCTAssertEqual(topicWithDetail.integrations.count, 1)
        
        let topicServiceIntegration = topicWithDetail.integrations[0]
        let integration  = topicServiceIntegration.integration
        XCTAssertEqual(integration.id, 22)
        XCTAssertEqual(integration.linkUrl, URL(string: "https://xxxxx.backlog.jp/projects/XXXXXXXX"))
        XCTAssertEqual(integration.configurationUrl == nil, true)
        
        let service = topicServiceIntegration.service
        XCTAssertEqual(service.name, "backlog")
        XCTAssertEqual(service.fullName, "Backlog")
        XCTAssertEqual(service.summary, "<a href=\"http://backlogtool.com/\" target=\"_blank\">Backlog</a> integration provides you the ability to keep up to date with various events from Backlog.")
        XCTAssertEqual(service.imageUrl, URL(string: "https://deeb7lj8m1sjw.cloudfront.net/dfcaf70905e7b42e4225e560a0daea443c9b81f6/assets/images/integration/backlog.png"))
        
        XCTAssertEqual(topicWithDetail.remainingInvitations == nil, true)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetTeams() {
    withStub(name: "get-teams")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetTeams()) { (result) -> Void in
      switch result {
      case .success(let value):
        let teamWithInfos = value.teams
        XCTAssertEqual(teamWithInfos.count, 2)
        
        let teamWithInfo = teamWithInfos[0]
        let team = teamWithInfo.team
        
        XCTAssertEqual(teamWithInfos.count, 2)
        XCTAssertEqual(team.id, 301)
        XCTAssertEqual(team.name, "Developers")
        XCTAssertEqual(team.imageUrl, URL(string: "http://nulabapps.local:18080/nulab-account-web/spaces/abcdefghij/photo/large"))
        XCTAssertEqual(team.createdAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        XCTAssertEqual(team.updatedAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetFriends() {
    withStub(name: "get-friends")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetFriends(q: "", offset: nil, count: nil)) { (result) -> Void in
      switch result {
      case .success(let accountsNormal):
        XCTAssertEqual(accountsNormal.count, 1)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetAccount() {
    withStub(name: "get-account")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetAccount(nameOrEmailAddress: "")) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetAccountsStatus() {
    withStub(name: "get-accounts-status")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetAccountsStatus(accountIds: [])) { (result) -> Void in
      switch result {
      case .success(let value):
        let accountWithStatuses = value.accounts
        XCTAssertEqual(accountWithStatuses.count, 2)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetAccountProfile() {
    withStub(name: "get-account-profile")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetAccountProfile(accountName: "")) { (result) -> Void in
      switch result {
      case .success(let accountProfileWithStatus):
        let account = accountProfileWithStatus.account
        XCTAssertEqual(account.id, 103)
        XCTAssertEqual(account.name, "stefhull")
        XCTAssertEqual(account.fullName, "StefHull")
        XCTAssertEqual(account.suggestion, "StefHull")
        XCTAssertEqual(account.imageUrl, URL(string: "https://typetalk.com/accounts/103/profile_image.png?t=1403836349000"))
        XCTAssertEqual(account.mailAddress, "example@example.com")
        XCTAssertEqual(account.createdAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
        XCTAssertEqual(account.updatedAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
        XCTAssertEqual(account.imageUpdatedAt, ISO8601DateFormatter().date(from: "2014-06-27T02:32:29Z"))
        
        let status = accountProfileWithStatus.status
        XCTAssertEqual(status.presence, .away)
        XCTAssertEqual(status.web == nil, true)
        XCTAssertEqual(status.mobile == nil, true)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetTopic() {
    withStub(name: "get-topic")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetTopic(topicId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPutUpdateTopic() {
    withStub(name: "put-update-topic")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PutTopic(topicId: 1, name: "", description: nil, teamId: nil)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostRemoveTopicMembers() {
    withStub(name: "post-remove-topic-members")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostRemoveTopicMembers(topicId: 1, removeInviteIds: nil, removeMemberIds: nil)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostInviteTopicMembers() {
    withStub(name: "post-invite-topic-members")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostInviteTopicMembers(topicId: 1, inviteMembers: nil, inviteMessage: nil)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostUpdateTopicMembers() {
    withStub(name: "post-update-topic-members")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostUpdateTopicMembers(topicId: 1, addAccountIds: nil, addGroupIds: nil, removeAccountIds: nil, removeGroupIds: nil)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetMentions() {
    withStub(name: "get-mentions")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetMentions(from: nil, unread: nil)) { (result) -> Void in
      switch result {
      case .success(let value):
        let mentionPosts = value.mentions
        XCTAssertEqual(mentionPosts.count, 2)
        
        let mentionPost = mentionPosts[0]
        XCTAssertEqual(mentionPost.id, 501)
        XCTAssertEqual(mentionPost.readAt == nil, true)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetNotifications() {
    withStub(name: "get-notifications")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetNotifications()) { (result) -> Void in
      switch result {
      case .success(let notifications):
        XCTAssertEqual(notifications.mentions.count, 2)
        
        let invites = notifications.invites
        
        XCTAssertEqual(invites.teams.count, 1)
        
        let inviteTeams = invites.teams
        XCTAssertEqual(inviteTeams.count, 1)
        
        let inviteTeam = inviteTeams[0]
        XCTAssertEqual(inviteTeam.id, 501)
        XCTAssertEqual(inviteTeam.role, .member)
        XCTAssertEqual(inviteTeam.message, "It is a new project. Join us!")
        XCTAssertEqual(inviteTeam.createdAt, ISO8601DateFormatter().date(from: "2014-07-04T02:32:29Z"))
        XCTAssertEqual(inviteTeam.updatedAt, ISO8601DateFormatter().date(from: "2014-07-04T02:32:29Z"))
        
        let inviteTopics = invites.topics
        XCTAssertEqual(inviteTopics.count, 2)
        
        let inviteTopic = inviteTopics[0]
        XCTAssertEqual(inviteTopic.id, 601)
        XCTAssertEqual(inviteTopic.message, "It is a new project. Join us!")
        XCTAssertEqual(inviteTopic.createdAt, ISO8601DateFormatter().date(from: "2014-07-04T02:32:29Z"))
        XCTAssertEqual(inviteTopic.updatedAt, ISO8601DateFormatter().date(from: "2014-07-04T02:32:29Z"))
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostAcceptTeamInvitation() {
    withStub(name: "post-accept-team-invitation")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostAcceptTeamInvitation(teamId: 1, inviteId: 1)) { (result) -> Void in
      switch result {
      case .success(let inviteTeamWithTopics):
        XCTAssertEqual(inviteTeamWithTopics.topics.count, 2)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostDeclineTeamInvitation() {
    withStub(name: "post-decline-team-invitation")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostDeclineTeamInvitation(teamId: 1, inviteId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetNotificationStatus() {
    withStub(name: "get-notification-status")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetNotificationStatus()) { (result) -> Void in
      switch result {
      case .success(let notificationStatus):
        XCTAssertEqual(notificationStatus.mention.unread, 145)
        XCTAssertEqual(notificationStatus.access.unopened, 0)
        
        let invite = notificationStatus.invite
        XCTAssertEqual(invite.team.pending, 0)
        XCTAssertEqual(invite.topic.pending, 0)
        
        let likeReceive = notificationStatus.like.receive
        XCTAssertEqual(likeReceive.hasUnread, false)
        XCTAssertEqual(likeReceive.readLikeId, 1626024)
        
        XCTAssertEqual(notificationStatus.directMessage.unreadTopics, 0)
        
        let doNotDisturb = notificationStatus.doNotDisturb
        XCTAssertEqual(doNotDisturb.isSuppressed, false)
        XCTAssertEqual(doNotDisturb.manual.remainingTimeInMinutes == nil, true)
        
        let scheduled = doNotDisturb.scheduled
        XCTAssertEqual(scheduled.enabled, false)
        XCTAssertEqual(scheduled.start, "22:00")
        XCTAssertEqual(scheduled.end, "08:00")
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPutNotifications() {
    withStub(name: "put-notifications")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PutNotifications()) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostAcceptTopicInvitation() {
    withStub(name: "post-accept-topic-invitation")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostAcceptTopicInvitation(topicId: 1, inviteId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostDeclineTopicInvitation() {
    withStub(name: "post-decline-topic-invitation")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostDeclineTopicInvitation(topicId: 1, inviteId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetBookmarks() {
    withStub(name: "get-bookmarks")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetBookmarks()) { (result) -> Void in
      switch result {
      case .success(let value):
        let unreads = value.unreads
        XCTAssertEqual(unreads.count, 3)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPutBookmarks() {
    withStub(name: "put-bookmarks")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PutBookmarks(topicId: 1, postId: nil)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetPost() {
    withStub(name: "get-post")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetPost(topicId: 1, postId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPutMentions() {
    withStub(name: "put-mentions")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PutMentions(mentionId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostLike() {
    withStub(name: "post-like")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostLike(topicId: 1, postId: 1)) { (result) -> Void in
      switch result {
      case .success(let likeWithDetail):
        let post = likeWithDetail.post
        XCTAssertEqual(post.id, 305)
        XCTAssertEqual(post.topicId, 208)
        XCTAssertEqual(post.replyTo == nil, true)
        XCTAssertEqual(post.message, "And I'm a 32 year old IT-man who works in a basement. Word.")
        XCTAssertEqual(post.createdAt, ISO8601DateFormatter().date(from: "2014-06-30T14:32:29Z"))
        XCTAssertEqual(post.updatedAt, ISO8601DateFormatter().date(from: "2014-06-30T14:32:29Z"))
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testDeleteLike() {
    withStub(name: "delete-like")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(DeleteLike(topicId: 1, postId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testDeletePost() {
    withStub(name: "delete-post")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(DeletePost(topicId: 1, postId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostPost() {
    withStub(name: "post-post")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostPost(topicId: 1, message: "", replyTo: nil, fileKeys: nil, talkIds: nil)) { (result) -> Void in
      switch result {
      case .success(let postWithInfo):
        let topic = postWithInfo.topic
        XCTAssertEqual(topic.id, 208)
        XCTAssertEqual(topic.name, "IT Peeps")
        XCTAssertEqual(topic.isDirectMessage, false)
        XCTAssertEqual(topic.lastPostedAt, ISO8601DateFormatter().date(from: "2016-12-21T10:11:57Z"))
        XCTAssertEqual(topic.createdAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        XCTAssertEqual(topic.updatedAt, ISO8601DateFormatter().date(from: "2014-06-10T02:32:29Z"))
        
        XCTAssertEqual(postWithInfo.mentions.count, 0)
        XCTAssertEqual(postWithInfo.exceedsAttachmentLimit, false)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPutPost() {
    withStub(name: "put-post")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PutPost(topicId: 1, postId: 1, message: "")) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostDMPost() {
    withStub(name: "post-dm-post")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostDMPost(accountName: "", message: "", replyTo: nil, fileKeys: nil, talkIds: nil)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostAttachment() {
    withStub(name: "post-attachment")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostAttachment(topicId: 1, data: Data(), fileName: "")) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetTalks() {
    withStub(name: "get-talks")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetTalks(topicId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetPostsInTalk() {
    withStub(name: "get-posts-in-talk")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetPostsInTalk(topicId: 1, talkId: 1, from: nil, direction: nil)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetTopicMembersStatuses() {
    withStub(name: "get-topic-members-statuses")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetTopicMembersStatuses(topicId: 1)) { (result) -> Void in
      switch result {
      case .success(let statuses):
        let accounts = statuses.accounts
        XCTAssertEqual(accounts.count, 2)
        
        let account = accounts[0]
        XCTAssertEqual(account.online, true)
        
        let pendings = statuses.pendings
        XCTAssertEqual(pendings.count, 2)
        
        let pending = pendings[1]
        XCTAssertEqual(pending.mailAddress, "example@example.com")
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetSpaces() {
    withStub(name: "get-spaces")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetSpaces()) { (result) -> Void in
      switch result {
      case .success(let value):
        let mySpaces = value.mySpaces
        XCTAssertEqual(mySpaces.count, 1)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetLikesReceived() {
    withStub(name: "get-likes-received")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetLikesReceived(from: nil)) { (result) -> Void in
      switch result {
      case .success(let value):
        let likedPosts = value.likedPosts
        XCTAssertEqual(likedPosts.count, 2)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetLikesGiven() {
    withStub(name: "get-likes-given")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetLikesGiven(from: nil)) { (result) -> Void in
      switch result {
      case .success(let value):
        let likedPosts = value.likedPosts
        XCTAssertEqual(likedPosts.count, 2)
        
        let myLike = likedPosts[0].myLike
        XCTAssertEqual(myLike.id, 605)
        XCTAssertEqual(myLike.comment, "")
        XCTAssertEqual(myLike.createdAt, ISO8601DateFormatter().date(from: "2016-12-21T10:12:06Z"))
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testGetLikesDiscover() {
    withStub(name: "get-likes-discover")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(GetLikesDiscover(from: nil)) { (result) -> Void in
      switch result {
      case .success(let value):
        let likedPosts = value.likedPosts
        XCTAssertEqual(likedPosts.count, 2)
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testPostLikeBookmark() {
    withStub(name: "post-like-bookmark")
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostLikeBookmark(likeId: 1)) { (result) -> Void in
      switch result {
      case .success:
        break
      case .failure(let error):
        print(error)
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
  
  func testBadRequest() {
    withStub(name: "bad-request-response", status: 400)
    
    let expecation = self.expectation(description: "Client")
    
    XCTAssertNoThrow(Client.send(PostPost(topicId: 1, message: "", replyTo: nil, fileKeys: nil, talkIds: nil)) { (result) -> Void in
      switch result {
      case .failure(APIError.badRequest(let response)):
        XCTAssertEqual(response.errors.count, 1)
        
        let error = response.errors.first
        XCTAssertEqual(error?.field, "message")
        XCTAssertEqual(error?.name, "error.postMessage.required")
        XCTAssertEqual(error?.message, "message or fileKeys required.")
      default:
        XCTFail()
      }
      
      expecation.fulfill()
    })
    
    self.waitForExpectations(timeout: 1, handler: nil)
  }
}
