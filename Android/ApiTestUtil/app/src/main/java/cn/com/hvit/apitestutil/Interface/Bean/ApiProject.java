package cn.com.hvit.apitestutil.Interface.Bean;

import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by JasonLee on 16/01/25.
 */
public class ApiProject {
    public String project_name;
    public String base_url;
    public String route_url;
    public ArrayList<ApiInterface> apiArray;

    public void init(Object data) {
        HashMap<String, Object> project = (HashMap<String, Object>) data;
        if (project != null) {
            this.project_name = project.get("project_name").toString();
            this.base_url = project.get("base_url").toString();
            this.route_url = project.get("route_url").toString();
            List<Object> tempArray = (List<Object>) project.get("apis");
            this.apiArray = new ArrayList<ApiInterface>();
            for (Object object :
                    tempArray) {
                ApiInterface api = new ApiInterface();
                api.init(object);
                this.apiArray.add(api);
            }
        }
    }

    public Object toObject() {
        HashMap<String, Object> object = new HashMap<String, Object>();

        object.put("project_name", project_name);
        object.put("base_url", base_url);
        object.put("route_url", route_url);
        object.put("apis", apiArray);

        return object;
    }

    public void logString() {
        Log.i("project_name", this.project_name);
        Log.i("base_url", this.base_url);
        Log.i("route_url", this.route_url);
        Log.i("apis", "");
        for (ApiInterface api :
                this.apiArray) {
            api.logString();
        }
    }
}
