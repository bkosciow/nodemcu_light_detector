#lm393 light detector on NodeMCU

more on [https://koscis.wordpress.com/tag/wc-project/](https://koscis.wordpress.com/tag/wc-project/)

##main
Main app. Bases on lua boilerplate [https://github.com/bkosciow/nodemcu_boilerplate](https://github.com/bkosciow/nodemcu_boilerplate).
It broadcast message on state change (light on/off).

Set your AP credentials in parameters.lua

It also respond to ask for state 
    
    {
        "protocol": "iot:1",
        "node": "computer",
        "event": "state",
        "targets": [
            "light-wc"
        ]
    }

with current light state.

    {
        "chip_id":183164,
        "protocol":"iot:1",
        "node":"light-wc",
        "targets":["ALL"],
        "event":"",
        "response":"detect.light"
    }
