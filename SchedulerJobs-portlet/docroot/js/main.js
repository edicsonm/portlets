AUI.add('scheduledjobutil', function(A){
//	var form = A.one('form');
	
	A.namespace('scheduledjobutil');
	
	A.scheduledjobutil.setPortletNamespace = function(pns){
		portletNamespace = pns;
	};
	
	A.scheduledjobutil.actionButtonHandler = function(event) {
		var form = A.one('#'+portletNamespace+'jobsActionsForm');
		event.preventDefault();
    	var action = event.target.get('id');
    	A.one('#'+portletNamespace+'jobAction').val(action);
    	if (action == 'shutdown'){
    		alert('Dialog option')
    		A.scheduledjobutil.showDialog();
    	}else{
    		form.submit();
    	}
    };
},
'',
{
    requires: ['liferay-util-window']
}
);