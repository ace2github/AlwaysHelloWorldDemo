import React from 'react';

class NetworkManager  {
  getRequest(url, successCallBack, failureBallBack) {
    opt = {
      method: 'GET',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json'
      },
    };

    // requst
    this.startRequest(url, opt, successCallBack, failureBallBack);
  }

  postRequest(url, body, successCallBack, failureBallBack) {
    opt = {
      method: 'POST',
      headers: {
        Accept: 'application/json',
        'Content-Type': 'application/json'
      },
      body: body
    };

    // requst
    this.startRequest(url, opt, successCallBack, failureBallBack);
  }

  startRequest(url, opt, successCallBack, failureBallBack) {
    fetch(url, opt)
    .then((response)=>{
      return response.json();
    })
    .then((responseJson)=>{
      if (successCallBack) successCallBack(responseJson);
    })
    .catch((err)=>{
      if (failureBallBack) failureBallBack(err);
    });
  }

}

export default NetworkManager;
