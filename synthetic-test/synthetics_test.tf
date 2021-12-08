resource "datadog_monitor" "tfer--monitor_56896696" {
  escalation_message = "Follow up with the AWS to get more detailed overview. And timeline for resolution"
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "@all\n \n One or more AWS regions are experiencing issues"

  monitor_thresholds {
    critical = "3"
    ok       = "1"
    warning  = "1"
  }

  name                 = "One or more AWS regions are experiencing issues"
  new_group_delay      = "60"
  new_host_delay       = "0"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "1"
  query                = "\"aws.status\".over(\"region:us-east-1\",\"region:us-east-2\",\"region:us-west-1\",\"region:us-west-2\").by(\"region\",\"service\").last(4).count_by_status()"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["alert"]
  require_full_window  = "false"
  timeout_h            = "0"
  type                 = "service check"
}

resource "datadog_monitor" "tfer--monitor_56897185" {
  escalation_message = "Failure to resolve the issue might result in system unresponsive."
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "@all\n \n Check the logs to learn more about the issue"

  monitor_thresholds {
    critical          = "5e+08"
    critical_recovery = "2e+09"
    warning           = "1e+09"
    warning_recovery  = "4e+09"
  }

  name                 = "Host{{host.name}}  is running on low memory."
  new_group_delay      = "60"
  new_host_delay       = "0"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "1"
  query                = "min(last_5m):avg:system.mem.free{host:i-06bfa216e69cb29f3} by {host} + avg:system.mem.free{host:i-0e52b6bb71e337120} by {host} <= 500000000"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["alert", "warn"]
  require_full_window  = "false"
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "tfer--monitor_56897574" {
  escalation_message = "{{host.name}} is not responsive. Please check."
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "Please Note {{host.name}} is not responding. \n\n@all"

  monitor_thresholds {
    critical = "1"
    ok       = "1"
    warning  = "1"
  }

  name                 = "host{{host.ip}}   is not reporting"
  new_group_delay      = "60"
  new_host_delay       = "0"
  no_data_timeframe    = "5"
  notify_audit         = "false"
  notify_no_data       = "true"
  priority             = "1"
  query                = "\"datadog.agent.up\".over(\"host:i-06bfa216e69cb29f3\",\"host:i-0e52b6bb71e337120\").by(\"host\").last(2).count_by_status()"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["alert"]
  require_full_window  = "false"
  timeout_h            = "0"
  type                 = "service check"
}

resource "datadog_monitor" "tfer--monitor_56898012" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "@all"

  monitor_thresholds {
    critical = "3"
    ok       = "5"
    warning  = "1"
  }

  name                 = "{{host.name}}  The EC2 Host is unresponsive"
  new_group_delay      = "60"
  new_host_delay       = "0"
  no_data_timeframe    = "10"
  notify_audit         = "false"
  notify_no_data       = "true"
  priority             = "1"
  query                = "\"aws.ec2.host_status\".over(\"host:i-06bfa216e69cb29f3\",\"host:i-0e52b6bb71e337120\").by(\"host\").last(6).count_by_status()"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["no data", "alert"]
  require_full_window  = "false"
  timeout_h            = "0"
  type                 = "service check"
}

resource "datadog_monitor" "tfer--monitor_56903419" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`pymysql` error rate is too high."

  monitor_thresholds {
    critical = "0.5"
    warning  = "0.25"
  }

  name                 = "Service pymysql has a high error rate on env:prod"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "0"
  query                = "sum(last_10m):(sum:trace.pymysql.query.errors{env:prod,service:pymysql,host:i-0e52b6bb71e337120}.as_count() / sum:trace.pymysql.query.hits{env:prod,service:pymysql,host:i-0e52b6bb71e337120}.as_count()) > 0.5"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "false"
  tags                 = ["env:prod", "service:pymysql"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "tfer--monitor_56903591" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`order-service` errors deviated too much from its usual value.\n @all"

  monitor_thresholds {
    critical = "0.5"
    warning  = "0.25"
  }

  name                 = "Service order-service has an abnormal change in errors on env:prod"
  new_group_delay      = "60"
  new_host_delay       = "0"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "1"
  query                = "avg(last_5m):avg:trace.flask.request.errors{env:prod,service:order-service,host:i-0e52b6bb71e337120} by {host}.as_rate() + avg:trace.flask.request.hits{env:prod,service:order-service,host:i-0e52b6bb71e337120} by {host}.as_rate() > 0.5"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["alert", "no data", "warn"]
  require_full_window  = "false"
  tags                 = ["env:prod", "service:order-service"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "tfer--monitor_56903715" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`product-service` throughput deviated too much from its usual value.\n @all"

  monitor_thresholds {
    critical = "0.5"
    warning  = "0.25"
  }

  name                 = "Service product-service has an abnormal change in throughput on env:prod"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "1"
  query                = "avg(last_5m):sum:trace.flask.request.errors{service:product-service,host:i-0e52b6bb71e337120}.as_rate() / sum:trace.flask.request.hits{service:product-service,host:i-0e52b6bb71e337120}.as_rate() > 0.5"
  renotify_interval    = "0"
  renotify_occurrences = "0"
  require_full_window  = "false"
  tags                 = ["service:product-service", "env:prod"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "tfer--monitor_56903832" {
  escalation_message = "`requests` throughput deviated too much from its usual value."
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`requests` throughput deviated too much from its usual value.\n @all"

  monitor_thresholds {
    critical = "0.5"
    warning  = "0.25"
  }

  name                 = "Service requests has an abnormal change in throughput on env:prod"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "1"
  query                = "avg(last_5m):sum:trace.requests.request.errors{env:prod,service:requests,host:i-0e52b6bb71e337120}.as_rate() / sum:trace.requests.request.hits{env:prod,service:requests,host:i-0e52b6bb71e337120}.as_rate() > 0.5"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["alert", "no data", "warn"]
  require_full_window  = "false"
  tags                 = ["env:prod", "service:requests"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "tfer--monitor_56903889" {
  escalation_message = "`shop-frontend` throughput deviated too much from its usual value."
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`shop-frontend` throughput deviated too much from its usual value.\n @all"

  monitor_thresholds {
    critical = "0.5"
    warning  = "0.25"
  }

  name                 = "Service shop-frontend has an abnormal change in throughput on env:prod"
  new_group_delay      = "60"
  new_host_delay       = "0"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "1"
  query                = "avg(last_5m):sum:trace.flask.request.errors{env:prod,service:shop-frontend,host:i-0e52b6bb71e337120} by {host}.as_rate() / sum:trace.flask.request.hits{env:prod,service:shop-frontend,host:i-0e52b6bb71e337120} by {host}.as_rate() > 0.5"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["alert", "no data", "warn"]
  require_full_window  = "false"
  tags                 = ["service:shop-frontend", "env:prod"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "tfer--monitor_56903907" {
  escalation_message = "`user-service` throughput deviated too much from its usual value."
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "`user-service` throughput deviated too much from its usual value.\n @all"

  monitor_thresholds {
    critical = "90"
    warning  = "75"
  }

  name                 = "Service user-service has an abnormal change in throughput on env:prod"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "1"
  query                = "avg(last_5m):sum:trace.flask.request.errors{env:prod,service:user-service}.as_rate() + sum:trace.flask.request.hits{env:prod,service:user-service}.as_rate() > 90"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["alert", "warn", "no data"]
  require_full_window  = "false"
  tags                 = ["service:user-service", "env:prod"]
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_monitor" "tfer--monitor_56974213" {
  escalation_message = ""
  evaluation_delay   = "0"
  include_tags       = "true"
  locked             = "false"
  message            = "@all"

  monitor_thresholds {
    critical = "8"
  }

  name                 = "The number of running containers is less than 8"
  new_group_delay      = "0"
  new_host_delay       = "300"
  no_data_timeframe    = "0"
  notify_audit         = "false"
  notify_no_data       = "false"
  priority             = "0"
  query                = "avg(last_5m):sum:docker.containers.running.total{host:i-0e52b6bb71e337120} < 8"
  renotify_interval    = "30"
  renotify_occurrences = "0"
  renotify_statuses    = ["warn", "alert"]
  require_full_window  = "false"
  timeout_h            = "0"
  type                 = "query alert"
}

resource "datadog_synthetics_test" "tfer--synthetics_5mb-chc-aux" {
  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Click on link \"Login\""

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/login\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"login\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/login\\\">Login</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Home\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][1]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" navbar \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\")][1]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" navbar \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"home\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"home\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"home\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/\\\">Home</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Login\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/login\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"login\\\",\\\"textType\\\":\\\"directText\\\"},{\\\"relation\\\":\\\"PARENT OF\\\",\\\"tagName\\\":\\\"NAV\\\",\\\"text\\\":\\\" home login register checkout 0 \\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@href=\\\"/login\\\"]\"},\"targetOuterHTML\":\"<a href=\\\"/login\\\">Login</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Checkout 0\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][3]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/checkout\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][3]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"checkout\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"checkout\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"checkout\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/checkout\\\">Checkout <span class=\\\"badge\\\">\\n\\n    \\n0\\n</span></a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading heading \"Login\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"h1\\\"][1]\",\"at\":\"/*[local-name()=\\\"html\\\"]/*[local-name()=\\\"body\\\"]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"h1\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/*[local-name()=\\\"h1\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"login\\\",\\\"textType\\\":\\\"directText\\\"},{\\\"relation\\\":\\\"AFTER\\\",\\\"tagName\\\":\\\"STRONG\\\",\\\"text\\\":\\\"login\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[local-name()=\\\"h1\\\"]\"},\"targetOuterHTML\":\"<h1>Login</h1>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading label \"Username\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"label\\\"][1]\",\"at\":\"/descendant::*[@method=\\\"post\\\"]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"label\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-label \\\")][1]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"username\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"username\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"username\\\"]]\"},\"targetOuterHTML\":\"<label class=\\\"form-label\\\" for=\\\"username\\\">Username</label>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #username is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"input\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"username\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][1]\",\"co\":\"[{\\\"text\\\":\\\"username\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"username\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"form-control\\\" id=\\\"username\\\" name=\\\"username\\\" required=\\\"\\\" type=\\\"text\\\" value=\\\"\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading label \"Password\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"label\\\"][1]\",\"at\":\"/descendant::*[@method=\\\"post\\\"]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"label\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-label \\\")][2]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"password\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"password\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"password\\\"]]\"},\"targetOuterHTML\":\"<label class=\\\"form-label\\\" for=\\\"password\\\">Password</label>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #password is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"input\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"password\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][2]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][2]\",\"co\":\"[{\\\"text\\\":\\\"password\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"password\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"form-control\\\" id=\\\"password\\\" name=\\\"password\\\" required=\\\"\\\" type=\\\"password\\\" value=\\\"\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #submit is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"input\\\"][2]\",\"at\":\"/descendant::*[@name=\\\"submit\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"co\":\"[{\\\"relation\\\":\\\"AFTER\\\",\\\"tagName\\\":\\\"INPUT\\\",\\\"text\\\":\\\" password: \\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"submit\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"btn btn-success pull-right\\\" id=\\\"submit\\\" name=\\\"submit\\\" type=\\\"submit\\\" value=\\\"Login\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/login\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  device_ids = ["chrome.laptop_large", "firefox.laptop_large", "edge.laptop_large"]
  locations  = ["aws:ca-central-1", "aws:ap-south-1", "aws:ap-southeast-2", "aws:sa-east-1", "aws:ap-northeast-2", "aws:us-west-1", "aws:us-east-2", "aws:ap-southeast-1", "aws:ap-northeast-1", "aws:eu-west-2", "aws:eu-north-1", "aws:eu-central-1", "aws:eu-west-3", "azure:eastus", "aws:eu-west-1", "aws:us-west-2"]
  message    = "\n@bhosale.a@husky.neu.edu @lu.zix@northeastern.edu @udipi.k@northeastern.edu @srampickaljoseph.v@northeastern.edu"
  name       = "LoginPageTest-terr"

  options_list {
    accept_self_signed   = "false"
    allow_insecure       = "false"
    follow_redirects     = "false"
    min_failure_duration = "0"
    min_location_failed  = "1"
    monitor_name         = "LoginPage Test Case terr"

    monitor_options {
      renotify_interval = "0"
    }

    monitor_priority = "3"
    no_screenshot    = "false"

    retry {
      count    = "1"
      interval = "300"
    }

    tick_every = "3600"
  }

  request_definition {
    dns_server_port         = "0"
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    port                    = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "http://ec2-3-19-66-171.us-east-2.compute.amazonaws.com:8080/"
  }

  status = "live"
  type   = "browser"
}

resource "datadog_synthetics_test" "tfer--synthetics_84b-krb-hi6" {
  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Home\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][1]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" navbar \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\")][1]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" navbar \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"home\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"home\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"home\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/\\\">Home</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Login\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/login\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"login\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/login\\\">Login</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Register\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][2]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/register\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][2]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"register\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"register\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"register\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/register\\\">Register</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Checkout 0\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][3]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/checkout\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][3]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"checkout\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"checkout\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"checkout\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/checkout\\\">Checkout <span class=\\\"badge\\\">\\n\\n    \\n0\\n</span></a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading div \"prod1 Price: 100 $ View more\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]\",\"at\":\"/*[local-name()=\\\"html\\\"]/*[local-name()=\\\"body\\\"]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/*[local-name()=\\\"div\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/*[local-name()=\\\"div\\\"][1]\",\"co\":\"[{\\\"relation\\\":\\\"BEFORE\\\",\\\"tagName\\\":\\\"DIV\\\",\\\"text\\\":\\\" prod2 price: 200 $ view more \\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[1]\"},\"targetOuterHTML\":\"<div class=\\\"col-md-4\\\">\\n    <div class=\\\"panel panel-default\\\">\\n        <div class=\\\"panel-heading\\\">\\n   \",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading div \"prod2 Price: 200 $ View more\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]\",\"at\":\"/*[local-name()=\\\"html\\\"]/*[local-name()=\\\"body\\\"]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"div\\\"][2]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/*[local-name()=\\\"div\\\"][2]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/*[local-name()=\\\"div\\\"][2]\",\"co\":\"[{\\\"relation\\\":\\\"AFTER\\\",\\\"tagName\\\":\\\"DIV\\\",\\\"text\\\":\\\" prod1 price: 100 $ view more \\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[2]/*[local-name()=\\\"div\\\"][2]\"},\"targetOuterHTML\":\"<div class=\\\"col-md-4\\\">\\n    <div class=\\\"panel panel-default\\\">\\n        <div class=\\\"panel-heading\\\">\\n   \",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  device_ids = ["chrome.laptop_large", "firefox.laptop_large", "edge.laptop_large"]
  locations  = ["aws:eu-central-1", "aws:eu-north-1", "aws:us-west-1", "aws:ap-northeast-2", "aws:eu-west-2", "azure:eastus", "aws:eu-west-3", "aws:ap-southeast-1", "aws:ca-central-1", "aws:ap-northeast-1", "aws:ap-southeast-2", "aws:ap-south-1", "aws:eu-west-1", "aws:us-east-2", "aws:sa-east-1", "aws:us-west-2"]
  message    = "@bhosale.a@husky.neu.edu @lu.zix@northeastern.edu @udipi.k@northeastern.edu @srampickaljoseph.v@northeastern.edu"
  name       = "HomePageLoading-terr"

  options_list {
    accept_self_signed   = "false"
    allow_insecure       = "false"
    follow_redirects     = "false"
    min_failure_duration = "0"
    min_location_failed  = "1"
    monitor_name         = "Home Page Loading Test Case terr"

    monitor_options {
      renotify_interval = "0"
    }

    monitor_priority = "2"
    no_screenshot    = "false"

    retry {
      count    = "1"
      interval = "300"
    }

    tick_every = "3600"
  }

  request_definition {
    dns_server_port         = "0"
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    port                    = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "http://ec2-3-19-66-171.us-east-2.compute.amazonaws.com:8080/"
  }

  status = "live"
  type   = "browser"
}

resource "datadog_synthetics_test" "tfer--synthetics_ypi-t2a-ztf" {
  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Click on link \"Register\""

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][2]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/register\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][2]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"register\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"register\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"register\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/register\\\">Register</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "click"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Home\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][1]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" navbar \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\")][1]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" navbar \\\")]/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"home\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"home\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"home\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/\\\">Home</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Login\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/login\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][1]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"login\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"login\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/login\\\">Login</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Register\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][2]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/register\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][2]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"register\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"register\\\",\\\"textType\\\":\\\"directText\\\"},{\\\"relation\\\":\\\"PARENT OF\\\",\\\"tagName\\\":\\\"NAV\\\",\\\"text\\\":\\\" home login register checkout 0 \\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@href=\\\"/register\\\"]\"},\"targetOuterHTML\":\"<a href=\\\"/register\\\">Register</a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading link \"Checkout 0\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"header\\\"][1]/*[local-name()=\\\"nav\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"ul\\\"][2]/*[local-name()=\\\"li\\\"][3]/*[local-name()=\\\"a\\\"][1]\",\"at\":\"/descendant::*[@href=\\\"/checkout\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/*[local-name()=\\\"li\\\"][3]/*[local-name()=\\\"a\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" nav \\\") and contains(concat(' ', normalize-space(@class), ' '), \\\" pull-right \\\")]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"checkout\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"checkout\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"checkout\\\"]]\"},\"targetOuterHTML\":\"<a href=\\\"/checkout\\\">Checkout <span class=\\\"badge\\\">\\n\\n    \\n0\\n</span></a>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading heading \"Register\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"h1\\\"][1]\",\"at\":\"/*[local-name()=\\\"html\\\"]/*[local-name()=\\\"body\\\"]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"h1\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/*[local-name()=\\\"h1\\\"][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" container \\\")][2]/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"register\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"register\\\",\\\"textType\\\":\\\"directText\\\"},{\\\"relation\\\":\\\"AFTER\\\",\\\"tagName\\\":\\\"STRONG\\\",\\\"text\\\":\\\"register\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[local-name()=\\\"h1\\\"]\"},\"targetOuterHTML\":\"<h1>Register</h1>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading label \"Username\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"label\\\"][1]\",\"at\":\"/descendant::*[@method=\\\"post\\\"]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"label\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-label \\\")][1]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"username\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"username\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"username\\\"]]\"},\"targetOuterHTML\":\"<label class=\\\"form-label\\\" for=\\\"username\\\">Username</label>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #username is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"input\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"username\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][1]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][1]\",\"co\":\"[{\\\"text\\\":\\\"username\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"username\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"form-control\\\" id=\\\"username\\\" name=\\\"username\\\" required=\\\"\\\" type=\\\"text\\\" value=\\\"\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading label \"First name\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"label\\\"][1]\",\"at\":\"/descendant::*[@method=\\\"post\\\"]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"label\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-label \\\")][2]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"first name\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"first name\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"first name\\\"]]\"},\"targetOuterHTML\":\"<label class=\\\"form-label\\\" for=\\\"first_name\\\">First name</label>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #first_name is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][2]/*[local-name()=\\\"input\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"first_name\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][2]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][2]\",\"co\":\"[{\\\"text\\\":\\\"first name\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"first_name\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"form-control\\\" id=\\\"first_name\\\" name=\\\"first_name\\\" required=\\\"\\\" type=\\\"text\\\" value=\\\"\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading label \"Last name\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][3]/*[local-name()=\\\"label\\\"][1]\",\"at\":\"/descendant::*[@method=\\\"post\\\"]/*[local-name()=\\\"div\\\"][3]/*[local-name()=\\\"label\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-label \\\")][3]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"last name\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"last name\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"last name\\\"]]\"},\"targetOuterHTML\":\"<label class=\\\"form-label\\\" for=\\\"last_name\\\">Last name</label>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #last_name is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][3]/*[local-name()=\\\"input\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"last_name\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][3]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][3]\",\"co\":\"[{\\\"text\\\":\\\"last name\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"last_name\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"form-control\\\" id=\\\"last_name\\\" name=\\\"last_name\\\" required=\\\"\\\" type=\\\"text\\\" value=\\\"\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading label \"Email address\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][4]/*[local-name()=\\\"label\\\"][1]\",\"at\":\"/descendant::*[@method=\\\"post\\\"]/*[local-name()=\\\"div\\\"][4]/*[local-name()=\\\"label\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-label \\\")][4]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"email address\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"email address\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"email address\\\"]]\"},\"targetOuterHTML\":\"<label class=\\\"form-label\\\" for=\\\"email\\\">Email address</label>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #email is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][4]/*[local-name()=\\\"input\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"email\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][4]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][4]\",\"co\":\"[{\\\"text\\\":\\\"email address\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"email\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"form-control\\\" id=\\\"email\\\" name=\\\"email\\\" required=\\\"\\\" type=\\\"text\\\" value=\\\"\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading label \"Password\" is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][5]/*[local-name()=\\\"label\\\"][1]\",\"at\":\"/descendant::*[@method=\\\"post\\\"]/*[local-name()=\\\"div\\\"][5]/*[local-name()=\\\"label\\\"][1]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-label \\\")][5]\",\"clt\":\"/descendant::*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"password\\\"]]\",\"co\":\"[{\\\"text\\\":\\\"password\\\",\\\"textType\\\":\\\"directText\\\"}]\",\"ro\":\"//*[text()[normalize-space(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ', 'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ')) = \\\"password\\\"]]\"},\"targetOuterHTML\":\"<label class=\\\"form-label\\\" for=\\\"password\\\">Password</label>\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #password is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"div\\\"][5]/*[local-name()=\\\"input\\\"][1]\",\"at\":\"/descendant::*[@name=\\\"password\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][5]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" form-control \\\")][5]\",\"co\":\"[{\\\"text\\\":\\\"password\\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"password\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"form-control\\\" id=\\\"password\\\" name=\\\"password\\\" required=\\\"\\\" type=\\\"password\\\" value=\\\"\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  browser_step {
    allow_failure        = "false"
    force_element_update = "false"
    name                 = "Test heading input #submit is present"

    params {
      delay      = "0"
      element    = "{\"multiLocator\":{\"ab\":\"/*[local-name()=\\\"html\\\"][1]/*[local-name()=\\\"body\\\"][1]/*[local-name()=\\\"div\\\"][1]/*[local-name()=\\\"form\\\"][1]/*[local-name()=\\\"input\\\"][2]\",\"at\":\"/descendant::*[@name=\\\"submit\\\"]\",\"cl\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"clt\":\"/descendant::*[contains(concat(' ', normalize-space(@class), ' '), \\\" btn \\\")]\",\"co\":\"[{\\\"relation\\\":\\\"AFTER\\\",\\\"tagName\\\":\\\"INPUT\\\",\\\"text\\\":\\\" password: \\\",\\\"textType\\\":\\\"innerText\\\"}]\",\"ro\":\"//*[@id=\\\"submit\\\"]\"},\"targetOuterHTML\":\"<input class=\\\"btn btn-success pull-right\\\" id=\\\"submit\\\" name=\\\"submit\\\" type=\\\"submit\\\" value=\\\"Register\\\">\",\"url\":\"http://ec2-18-208-163-152.compute-1.amazonaws.com:8080/register\"}"
      with_click = "false"
      x          = "0"
      y          = "0"
    }

    timeout = "0"
    type    = "assertElementPresent"
  }

  device_ids = ["chrome.laptop_large", "firefox.laptop_large", "edge.laptop_large"]
  locations  = ["aws:eu-west-2", "aws:ap-southeast-1", "aws:us-west-1", "aws:eu-west-3", "aws:ca-central-1", "aws:us-east-2", "aws:eu-central-1", "aws:eu-north-1", "aws:ap-northeast-2", "aws:ap-southeast-2", "aws:ap-south-1", "aws:eu-west-1", "aws:ap-northeast-1", "aws:sa-east-1", "aws:us-west-2", "azure:eastus"]
  message    = "\n@bhosale.a@husky.neu.edu @lu.zix@northeastern.edu @udipi.k@northeastern.edu @srampickaljoseph.v@northeastern.edu"
  name       = "RegisterPageTest-terr"

  options_list {
    accept_self_signed   = "false"
    allow_insecure       = "false"
    follow_redirects     = "false"
    min_failure_duration = "0"
    min_location_failed  = "1"
    monitor_name         = "Register Page Test Case terr"

    monitor_options {
      renotify_interval = "0"
    }

    monitor_priority = "3"
    no_screenshot    = "false"

    retry {
      count    = "1"
      interval = "300"
    }

    tick_every = "3600"
  }

  request_definition {
    dns_server_port         = "0"
    method                  = "GET"
    no_saving_response_body = "false"
    number_of_packets       = "0"
    port                    = "0"
    should_track_hops       = "false"
    timeout                 = "0"
    url                     = "http://ec2-3-19-66-171.us-east-2.compute.amazonaws.com:8080/"
  }

  status = "live"
  type   = "browser"
}
