package cn.com.hvit.apitestutil.Interface.Bean;

import android.util.Log;

import java.util.HashMap;

/**
 * Created by JasonLee on 16/01/25.
 */
public class ApiInterface {
    public String api_name;
    public String api_url;
    public HashMap<String, String> request_params;
    public HashMap<String, String> response_params;
    public String projectName;

    public void init(Object data) {
        HashMap<String, Object> api = (HashMap<String, Object>) data;
        if (api != null) {
            this.api_name = api.get("api_name").toString();
            String unsolvedString = api.get("api_url").toString();

            String[] splited = unsolvedString.split("@");
            Log.i("旧字符串", unsolvedString);
//            for (String splitedString :
//                    splited) {
//                this.api_url += splitedString;
//            }
            this.api_url = splited[0] + "&" + splited[1] + "&" + splited[2];
            Log.i("新字符串", this.api_url);

            this.request_params = (HashMap<String, String>) api.get("request_params");
            this.response_params = (HashMap<String, String>) api.get("response_params");
        }
    }

    public Object toObject() {
        HashMap<String, Object> object = new HashMap<String, Object>();

        object.put("api_name", api_name);
        object.put("api_url", api_url);
        object.put("request_params", request_params);
        object.put("response_params", response_params);

        return object;
    }

    public void logString() {
        Log.i("api_name", this.api_name);
        Log.i("api_url", this.api_url);
        Log.i("request_params", this.request_params.toString());
        Log.i("response_params", this.response_params.toString());
    }
}
