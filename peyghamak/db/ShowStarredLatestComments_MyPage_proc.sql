--	All rights reserved to Alireza Poshtkohi (c) 1999-2023.
--	Email: arp@poshtkohi.info
--	Website: http://www.poshtkohi.info

USE [peyghamak-comments-1]
GO
-- =============================================
-- Create procedure with OUTPUT Parameters
-- =============================================
-- creating the store procedure
IF EXISTS (SELECT name 
	   FROM   sysobjects 
	   WHERE  name = 'ShowStarredLatestComments_MyPage_proc' 
	   AND 	  type = 'P')
    DROP PROCEDURE ShowStarredLatestComments_MyPage_proc
GO

CREATE PROCEDURE ShowStarredLatestComments_MyPage_proc

@BlogID BIGINT,
@TopLatestComments INT,
@IsAccountsDbLinkedServer BIT,
@IsPosts1DbLinkedServer BIT,
@IsStarredPosts1DbLinkedServer BIT

AS

SET ROWCOUNT @TopLatestComments;


IF (@IsAccountsDbLinkedServer=0 AND @IsPosts1DbLinkedServer=1)
BEGIN
	IF (@IsStarredPosts1DbLinkedServer=1)
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM [peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN STARREDPOSTS1DB.[peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 
			INNER JOIN POSTS1DB.[peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN [peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;
	END
	ELSE
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM [peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN [peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 
			INNER JOIN POSTS1DB.[peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN [peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;
	END
END

IF (@IsAccountsDbLinkedServer=1 AND @IsPosts1DbLinkedServer=1)
BEGIN
	IF (@IsStarredPosts1DbLinkedServer=1)
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM [peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN STARREDPOSTS1DB.[peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 		
			INNER JOIN POSTS1DB.[peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN ACCOUNTSDB.[peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;
	END
	ELSE
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM [peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN [peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 		
			INNER JOIN POSTS1DB.[peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN ACCOUNTSDB.[peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;		
	END

END

IF (@IsAccountsDbLinkedServer=1 AND @IsPosts1DbLinkedServer=0)
BEGIN
	IF (@IsStarredPosts1DbLinkedServer=1)
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM ACCOUNTSDB.[peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN STARREDPOSTS1DB.[peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 
			INNER JOIN [peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN ACCOUNTSDB.[peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;
	END
	ELSE
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM ACCOUNTSDB.[peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN [peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 
			INNER JOIN [peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN ACCOUNTSDB.[peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;
	END
END

ELSE
BEGIN
	IF (@IsStarredPosts1DbLinkedServer=1)
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM [peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN STARREDPOSTS1DB.[peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 
			INNER JOIN [peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN [peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;
	END
	ELSE
	BEGIN
		SELECT ac.ImageGuid,ac.username,ac.[name],co.[id],co.PostID,co.PostContent AS CommentContent,co.PostAlign AS CommentAlign,po.PostContent,po.PostAlign AS PostAlign,(SELECT [username] FROM [peyghamak-accounts].dbo.accounts WHERE [id]=po.BlogID AND IsDeleted=0) AS StarredUsername FROM [peyghamak-comments-1].dbo.comments AS co 
			INNER JOIN [peyghamak-StarredPosts-1].dbo.starred AS st 
			ON st.BlogID=@BlogID AND st.PostID=co.PostID AND st.IsDeleted=0 
			INNER JOIN [peyghamak-posts-1].dbo.posts AS po 
			ON co.PostID=po.[id] AND po.IsDeleted=0 
			INNER JOIN [peyghamak-accounts].dbo.accounts AS ac
			ON ac.[id]=co.CommenterBlogID and ac.IsDeleted=0 
			WHERE co.[id]<@LastID AND co.IsDeleted=0 ORDER BY co.[id] DESC;		
	END
END

SET ROWCOUNT 0;

RETURN ;