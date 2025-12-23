public class FlowStringToArray {

    @InvocableMethod(
        label='String to Array (JSON)'
        description='Converts a JSON array string into a List of Strings'
    )
    public static List<Response> stringToArray(List<Request> requests) {

        List<Response> responses = new List<Response>();

        for (Request req : requests) {
            Response res = new Response();
            res.caseIds = new List<String>();

            if (String.isNotBlank(req.inputString)) {
                try {
                    
                    
                    // Deserialize JSON into Map
                    Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(req.inputString);

                    // Extract caseIds
                    if (jsonMap.containsKey('caseIds')) {
                        List<Object> rawCaseIds = (List<Object>) jsonMap.get('caseIds');

                        for (Object obj : rawCaseIds) {
                            res.caseIds.add(String.valueOf(obj));
                        }
                    }
                    
                    // Extract Description
                    if (jsonMap.containsKey('Description')) {
						res.description = (String) jsonMap.get('Description');
                    }
                    
                    // Extract Subject
                    if (jsonMap.containsKey('Subject')) {
                        res.subject = (String) jsonMap.get('Subject');
                    }
                    

                } catch (Exception e) {
                    // Fail-safe: return empty list
                    res.caseIds = new List<String>();
                }
            }

            responses.add(res);
        }

        return responses;
    }

    // ===== Request Wrapper =====
    public class Request {
        @InvocableVariable(
            required=true
            label='Input String'
            description='JSON array string of Case Ids'
        )
        public String inputString;
    }

    // ===== Response Wrapper =====
    public class Response {
        @InvocableVariable(
            label='Case Id Array'
            description='Converted list of Case Ids'
        )
        public List<String> caseIds;
        
        @InvocableVariable(
            label='Summarized Description'
        )
        public String description;
        
        @InvocableVariable(
            label='Summarized Subject'
        )
        public String subject;
    }
}