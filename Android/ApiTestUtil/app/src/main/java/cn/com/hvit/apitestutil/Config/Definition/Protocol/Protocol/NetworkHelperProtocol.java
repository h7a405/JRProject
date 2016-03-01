package cn.com.hvit.apitestutil.Config.Definition.Protocol.Protocol;

/**
 * Created by JasonLee on 16/01/25.
 */
public interface NetworkHelperProtocol {

    void succeededWithResponseObject(String responseString);

    void failedWithError(String errorString);
}
