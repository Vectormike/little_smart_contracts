pragma solidity >=0.7.0 <0.9.0;

contract HelloBlockchain {
    enum StateType {
        Request,
        Respond
    }
    StateType State;
    address requestor;
    address responder;
    string requestMessage;
    string responseMessage;

    constructor(string memory message) {
        requestor = msg.sender;
        requestMessage = message;
        State = StateType.Request;
    }

    modifier oneRequestor() {
        require(msg.sender == requestor);
        _;
    }

    function sendRequest(string memory _requestMessage) public oneRequestor {
        requestMessage = _requestMessage;
        State = StateType.Request;
    }

    function sendResponse(string memory _responseMessage) public {
        responder = msg.sender;

        responseMessage = _responseMessage;
        State = StateType.Respond;
    }
}
