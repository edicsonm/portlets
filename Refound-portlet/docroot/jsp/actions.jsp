<%      
ResultRow row = (ResultRow)   request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
/* Article article= (Article) row.getObject(); */
 %>

<liferay-ui:icon-menu>
 <liferay-ui:icon image="edit" message="EDIT"
  url="<%= edirArticleURL.toString() %>" />

 <liferay-ui:icon image="delete" message="DELETE"
  url="<%= deleteArticleURL.toString() %>" />
</liferay-ui:icon-menu>