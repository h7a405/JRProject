package cn.com.hvit.apitestutil.Helper.Network;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import cn.com.hvit.apitestutil.Config.Definition.Protocol.Protocol.NetworkHelperProtocol;

/**
 * Created by JasonLee on 16/01/20.
 */
public class NetworkHelper {

    public NetworkHelperProtocol delegate;
    private String urlString;
    private HashMap<String, String> parameters;

    public NetworkHelper(NetworkHelperProtocol delegate) {
        this.delegate = delegate;
    }
    //Post方式请求
    public void postWithURL(String urlString, HashMap<String, String> parameters) {

        this.urlString = urlString;
        this.parameters = parameters;

        new Thread(runnable).start();
    }

    Handler handler = new Handler() {
        @Override
        public void handleMessage(Message message) {
            super.handleMessage(message);
            Bundle data = message.getData();
            String failed = data.getString("failed");
            String succeeded = data.getString("success");
            //Log.i("网络请求返回：", succeeded + failed);
            if (delegate != null) {
                if (failed == null) {
                    delegate.succeededWithResponseObject(succeeded);
                } else {
                    delegate.failedWithError(failed);
                }
            }
        }
    };

    Runnable runnable = new Runnable() {
        @Override
        public void run() {
            String response = "";

            try {
                URL url = new URL(urlString);

                HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                urlConnection.setReadTimeout(10000);
                urlConnection.setConnectTimeout(15000);
                urlConnection.setRequestMethod("POST");
                urlConnection.setDoInput(true);
                urlConnection.setDoOutput(true);

                OutputStream outputStream = urlConnection.getOutputStream();

                BufferedWriter bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream, "UTF-8"));

                bufferedWriter.write(convertParamsToString(parameters));
                bufferedWriter.flush();
                bufferedWriter.close();

                outputStream.close();

                int responseCode = urlConnection.getResponseCode();

                Message message = new Message();
                Bundle data = new Bundle();

                Log.i("URL:", urlString);
                Log.i("Params:", parameters.toString());

                if (responseCode == HttpsURLConnection.HTTP_OK) {
                    String line;
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
                    while ((line = bufferedReader.readLine()) != null) {
                        response += line;
                    }
//                    data.putString("success", response);

                    InputStream is = urlConnection.getInputStream(); // 获取输入流
                    byte[] datas = readStream(is); // 把输入流转换成字符串组
                    String json = new String(datas); // 把字符串组转换成字符串
                    data.putString("success", response);
                } else {
                    response = "";
                    data.putString("failed", "请求失败。");
                }
                message.setData(data);
                handler.sendMessage(message);

            } catch (Exception exception) {
                exception.printStackTrace();
            }
        }
    };

    private static byte[] readStream(InputStream inputStream) throws Exception {
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = inputStream.read(buffer)) != -1) {
            bout.write(buffer, 0, len);
        }
        bout.close();
        inputStream.close();
        return bout.toByteArray();
    }

    private String convertParamsToString(HashMap<String, String> params) throws UnsupportedEncodingException {
        StringBuilder result = new StringBuilder();
        boolean first = true;
        for (Map.Entry<String, String> entry : params.entrySet()) {
            if (first) {
                first = false;
            } else {
                result.append("&");
            }

            result.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
            result.append("=");
            result.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
        }
        return result.toString();
    }
}