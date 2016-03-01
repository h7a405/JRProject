package cn.com.hvit.apitestutil.Interface.Activity;

import android.support.annotation.IntDef;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;


import org.json.JSONException;
import org.json.JSONObject;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import cn.com.hvit.apitestutil.Config.Definition.Protocol.Protocol.NetworkHelperProtocol;
import cn.com.hvit.apitestutil.Helper.Network.NetworkHelper;
import cn.com.hvit.apitestutil.Interface.Bean.ApiInterface;
import cn.com.hvit.apitestutil.Interface.Bean.ApiProject;
import cn.com.hvit.apitestutil.R;
import cn.com.hvit.apitestutil.Util.PlistReader.PlistHandler;

/**
 * 版本：V1.0；
 * 内容：读取并解析Plist数据、Plist转换实例对象、一键请求接口测试；
 */

/**
 * 版本：V1.1；
 * 内容：在测试中可暂停、重新开始，数据统计；
 */

/**
 * 版本：V1.2；
 * 内容：测试报表；
 */

public class MainActivity extends ActionBarActivity implements NetworkHelperProtocol {
    //状态常量
    public static final int Prepared = 0;
    public static final int Loaded = 1;
    public static final int Loading = 2;
    public static final int LoadedFailure = 3;
    public static final int Running = 4;
    public static final int Holding = 5;
    public static final int Abort = 6;
    public static final int Finished = 7;

    //用@IntDef "包住" 常量；
    // @Retention 定义策略
    // 声明构造器
    @IntDef({Prepared, Loaded, Loading, LoadedFailure, Running, Holding, Abort, Finished})
    @Retention(RetentionPolicy.SOURCE)
    public @interface TestingStatus {
    }

    //MARK: 储存变量 - Int/Float/Double/String/Bool
    Integer currentProjectIndex = 0; //当前项目标记
    Integer currentApiIndex = 0; //当前api标记
    Integer currentApiRepeatCount = 0;   //api重复次数

    Boolean hasNextProject = false;  //是否有下一个项目
    Boolean isRepeatApi = false; //是否重复当前api
    //MARK: 集合类型 - Array/Dictionary/Tuple
    ArrayList<ApiProject> projects;   //项目列表
    ArrayList<ApiInterface> abnormalList;  //含有异常api的项目列表
    ArrayList<ApiInterface> failedList; //含有失败api的项目列表
    //MARK: 自定义类型 - Custom
    @TestingStatus
    int status = Prepared;   //当前状态
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    TextView loadLabel;
    Button loadButton;

    Button startButton;
    Button restartButton;

    TextView resultTextView;

    Button resultButton;

    TextView normalLabel;
    TextView abnormalLabel;
    TextView failedLabel;
    //MARK: Foundation - NS/CG/CA

    //MARK: 计算变量

    //MARK: 闭包与结构体 - Closure/Struct

    //MARK: 代理与数据源 - delegate/datasource

    //MARK: 重用 - Override/Required/Convenience
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.loadButton = (Button) findViewById(R.id.loadButton);
        this.startButton = (Button) findViewById(R.id.startButton);
        this.restartButton = (Button) findViewById(R.id.restartButton);
        this.resultButton = (Button) findViewById(R.id.resultButton);

        this.loadLabel = (TextView) findViewById(R.id.loadLabel);
        this.normalLabel = (TextView) findViewById(R.id.normalLabel);
        this.abnormalLabel = (TextView) findViewById(R.id.abnormalLabel);
        this.failedLabel = (TextView) findViewById(R.id.failedLabel);

        this.resultTextView = (TextView) findViewById(R.id.resultTextView);

        this.projects = new ArrayList<ApiProject>();
        this.abnormalList = new ArrayList<ApiInterface>();
        this.failedList = new ArrayList<ApiInterface>();

//        this.loadData();

    }
    //MARK: - 拓展
    //MARK: 初始化与配置 - Initailize & Setup

    //MARK: 操作与执行 - Action & Operation
    private void loadData() {
        @TestingStatus int tempStatus = this.status;
        Boolean hasNext = false;
        String text = "";
        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser parser = factory.newSAXParser();
            PlistHandler plistHandler = new PlistHandler();

            InputStream uri = getResources().openRawResource(R.raw.data);
            parser.parse(uri, plistHandler);

            List<Object> projectArray = plistHandler.getArrayResult();
            for (Object object :
                    projectArray) {
                ApiProject project = new ApiProject();
                project.init(object);
                this.projects.add(project);
                project.logString();
            }
            if (this.projects.size() > 0) {
                text = ("\n提取数据成功。");
                hasNext = true;
                tempStatus = Loaded;

                int apiNum = 0;
                for (ApiProject project :
                        this.projects) {
                    apiNum += project.apiArray.size();
                }
                this.normalLabel.setText("总接口数：" + apiNum);
            } else {
                throw new IndexOutOfBoundsException();
            }
        } catch (FileNotFoundException execption) {
            hasNext = false;
            tempStatus = LoadedFailure;
            text = ("\n没有数据文件。");
        } catch (IndexOutOfBoundsException exception) {
            hasNext = false;
            tempStatus = LoadedFailure;
            text = ("\n没有数据。");
        } catch (Exception exception) {
            Log.i("exception", exception.getMessage());
            hasNext = false;
            tempStatus = LoadedFailure;
            text = ("\n提取数据失败。");
        }

        resultTextView.append(text);
        hasNextProject = hasNext;
        status = tempStatus;

        this.updateStatus();
    }

    private void startTesting() {
        if (this.hasNextProject) {

            this.resultTextView.append("\n开始解析数据……");
            Log.i("开始", "开始解析数据……");

            this.goNextProject();
        } else {
            this.resultTextView.append("\n没有测试数据，开始重新加载。");
            Log.i("没有数据", "没有测试数据，开始重新加载。");

            this.status = Abort;
            this.updateStatus();
        }
    }

    private void endTesting() {
        this.status = Finished;
        this.updateStatus();
        this.reset();
    }

    private void checkGoNextApi() {
        switch (status) {
            case Running:
                this.goNextApi();
                break;
            default:
                break;
        }
    }

    private void goNextProject() {
        this.resetProject();
        if (this.currentProjectIndex + 1 <= this.projects.size()) {
            ApiProject project = this.projects.get(this.currentProjectIndex);

            this.resultTextView.append("\n开始测试项目：[" + (this.currentProjectIndex + 1) + "]" + project.project_name);
            Log.i("开始测试项目：", "[" + (this.currentProjectIndex + 1) + "]" + project.project_name);

            if (project.apiArray.size() > 0) {
                this.goNextApi();
            } else {
                this.resultTextView.append("\n没有接口数据，项目：" + project.project_name + "结束。");

                this.goNextProject();
            }
        } else {
            this.resultTextView.append("\n测试结束");

            this.endTesting();
        }
    }

    private void goNextApi() {
        if (this.currentApiIndex + 1 <= this.projects.get(this.currentProjectIndex).apiArray.size()) {
            ApiInterface api = this.projects.get(this.currentProjectIndex).apiArray.get(this.currentApiIndex);

            this.resultTextView.append("\n" + (this.isRepeatApi ? "【重试】" : "") + "开始测试接口：" + api.api_name);

            if (this.isRepeatApi) {
                if (this.currentApiRepeatCount >= 10) {
                    this.currentApiIndex++;
                    this.isRepeatApi = false;
                    this.currentApiRepeatCount = 0;
                    this.resultTextView.append("\n接口" + api.api_name + "重试次数过多，跳过接口。");

                    this.acquiredFailed(this.projects.get(this.currentProjectIndex), api);

                    this.goNextApi();
                    return;
                } else {
                    this.currentApiRepeatCount++;
                    this.resultTextView.append("\n" + (this.isRepeatApi ? "【重试】" : "") + "重试次数：" + this.currentApiRepeatCount + "次。");
                }
            }

            if (api.api_url == null || api.api_url.isEmpty()) {
                this.resultTextView.append("\n接口没有数据，跳过。");

                this.currentApiIndex++;
                this.currentApiRepeatCount = 0;
                this.isRepeatApi = false;

                this.checkGoNextApi();

                return;
            }
            String urlString = this.projects.get(this.currentProjectIndex).base_url + this.projects.get(this.currentProjectIndex).route_url + api.api_url;
            this.resultTextView.append("\n接口请求url地址：" + urlString);

            NetworkHelper networkHelper = new NetworkHelper(this);
            networkHelper.postWithURL(urlString, api.request_params);
        } else {
            this.currentProjectIndex++;
            this.currentApiRepeatCount = 0;
            this.currentApiIndex = 0;
            this.isRepeatApi = false;
            this.resultTextView.append("\n没有更多接口，该项目测试结束。");

            this.goNextProject();
        }
    }

    private void acquiredAbnormal(ApiProject project, ApiInterface api) {
        api.projectName = project.project_name;
        this.abnormalList.add(api);
        this.abnormalLabel.setText("异常数：" + this.abnormalList.size());
    }

    private void acquiredFailed(ApiProject project, ApiInterface api) {
        api.projectName = project.project_name;
        this.failedList.add(api);
        this.failedLabel.setText("失败数：" + this.failedList.size());
    }

    //MARK: 更新 - Update
    private void updateStatus() {
        this.updateLoadButton();
        this.updateStartButton();
        this.updateRestartButton();
        this.updateResultButton();
    }

    private void updateLoadButton() {
        Boolean enabled = true;
        String title = "";
        String text = "";
        switch (this.status) {
            case Prepared:
                title = "加载数据";
                text = "请先加载数据。";
                break;
            case Loading:
                title = "加 载 中";
                enabled = false;
                text = "加载中……";
                break;
            case LoadedFailure:
                title = "重新加载";
                text = "加载失败，请尝试重新加载。";
                break;
            case Loaded:
                title = "加载完成";
                enabled = false;
                text = "共加载：" + this.projects.size() + "个项目。";
                break;
            case Finished:
                title = "重新加载";
                break;
            default:
                title = "测 试 中";
                enabled = false;
                break;
        }
        this.loadButton.setText(title);
        this.loadButton.setClickable(enabled);
        this.loadLabel.setText(text);
    }

    private void updateStartButton() {
        Boolean enabled = true;
        String title = "";
        switch (this.status) {
            case Loaded:
                title = "开始测试";
                break;
            case Running:
                title = " 暂 停 ";
                break;
            case Holding:
                title = " 继 续 ";
                break;
            case Abort:
                title = "重新开始";
                break;
            default:
                title = "不可开始";
                enabled = false;
                break;
        }
        this.startButton.setText(title);
        this.startButton.setClickable(enabled);
    }

    private void updateRestartButton() {
        Boolean enabled = true;
        String title = "";
        switch (status) {
            case Holding:
                title = " 中 止 ";
                break;
            default:
                enabled = false;
                title = " ";
                break;
        }
        this.restartButton.setText(title);
        this.restartButton.setClickable(enabled);
    }

    private void updateResultButton() {
        Boolean enabled = true;
        String title = "";
        switch (this.status) {
            case Finished:
                title = "查看结果";
                break;
            default:
                title = "暂无结果";
                enabled = false;
                break;
        }
        this.resultButton.setText(title);
        this.resultButton.setClickable(enabled);
    }
    //MARK: 判断 - Judgement

    //MARK: 响应方法 - Selector
    public void didLoadButtonClicked(View view) {
        this.status = Loading;
        this.loadLabel.setText("");
        this.normalLabel.setText("");
        this.abnormalLabel.setText("");
        this.failedLabel.setText("");
        this.resultTextView.setText("");

        this.updateStatus();

        this.loadData();
    }

    public void didStartButtonClicked(View view) {
        switch (status) {
            case Loaded:
                this.status = Running;
                this.updateStatus();
                this.startTesting();
                break;
            case Running:
                this.status = Holding;
                this.updateStatus();
                break;
            case Holding:
                this.status = Running;
                this.updateStatus();
                this.checkGoNextApi();
                break;
            case Abort:
                this.status = Running;
                this.updateStatus();
                this.startTesting();
                break;
            default:
                break;
        }
    }

    public void didRestartButtonClicked(View view) {
        if (this.status == Holding) {
            this.status = Abort;
            this.updateStatus();
            this.resetStatus();
        }
    }

    public void didResultButtonClicked(View view) {

    }
    //MARK: 回调 - Call back

    //MARK: 数据源与代理 - DataSrouce & Delegate
    @Override
    public void succeededWithResponseObject(String responseString) {
        ApiProject project = this.projects.get(this.currentProjectIndex);
        ApiInterface api = project.apiArray.get(this.currentApiIndex);
        String text = "成功";
        try {
            JSONObject jsonObject = new JSONObject(responseString); // 返回的数据形式是一个Object类型，所以可以直接转换成一个Object
            int code = jsonObject.getInt("code");
            if (code != 0) {
                text = "异常";
                this.acquiredAbnormal(project, api);
            }
        } catch (JSONException e) {
            text = "异常";
            this.acquiredAbnormal(project, api);
        }
        resultTextView.append("=== 接口连接结果\n（*" + text + "*）\n=== 开始测试下个接口\n");
        Log.i("success", "接口测试返回成功，开始下一个接口。");
        Log.i("返回的数据：", responseString);

        currentApiIndex++;
        isRepeatApi = false;
        goNextApi();
    }

    @Override
    public void failedWithError(String errorString) {
        resultTextView.append("=== 接口连接结果\n(*失败*)\n=== 开始重新请求\n");

        Log.i("failed", "接口测试返回失败，即将重试。");

        isRepeatApi = true;
        checkGoNextApi();
    }

    //MARK: 设置 - Setter
    private void resetProject() {
        hasNextProject = false;
        isRepeatApi = false;
    }

    private void resetStatus() {
        currentProjectIndex = 0;
        currentApiRepeatCount = 0;
        currentApiIndex = 0;

        this.abnormalList = new ArrayList<ApiInterface>();
        this.failedList = new ArrayList<ApiInterface>();
    }

    private void reset() {
        this.resetProject();
        this.resetStatus();
        this.projects = new ArrayList<ApiProject>();
    }
    //MARK: 获取 - Getter

    //MARK: - 其他
    //MARK: 协议  -   Protocol

    //MARK: 枚举  -   Enumeration

}