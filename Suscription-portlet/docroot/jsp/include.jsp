<%@ include file="init.jsp" %>

<% 
	SubscriptionVO subscriptionVO = (SubscriptionVO)session.getAttribute("subscriptionVO");
	System.out.println("subscriptionVO.getTrialEnd(): " + subscriptionVO.getTrialEnd());
%>
<aui:input onkeypress="return false;" value="${Utils:formatDate(3,subscriptionVO.trialEnd,6)}"  label="label.trialEnd" helpMessage="help.trialEnd" showRequiredLabel="false" size="10" type="text" required="true" name="trialEndDay">
	 <aui:validator name="date" />
</aui:input>