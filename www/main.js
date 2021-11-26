function $(id) {
    return document.querySelector(id);
}

function $$(id) {
    return document.querySelectorAll(id);
}

function urlencode(str) {
    return str.replace(/%/g, '%25').replace(/\+/g, '%2B')
        .replace(/%20/g, '+').replace(/\*/g, '%2A')
        .replace(/\//g, '%2F').replace(/@/g, '%40')
        .replace(/&/g, '%26').replace(/;/g, '%3B')
        .replace(/\$/g, '%24').replace(/\?/g, '%3F');
}

function handler(data) {
    $("#code").innerHTML = data;
}

jx = {
    handler: false,
    error: false,
    opt: new Object(),

    load: function (url, callback, format = "text", method = "GET") {
        const xhr = new XMLHttpRequest();
        method = method.toUpperCase();
        format = format.toLowerCase();

        url += (url.indexOf("?") + 1) ? "&" : "?";
        url += "uid=" + new Date().getTime();

        let parameters = null;
        if (method === "POST") {
            const parts = url.split("?");
            url = parts[0];
            parameters = parts[1];
        }

        xhr.open(method, url, true);

        if (method === "POST") xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    let result = "";
                    switch (xhr.responseType) {
                        case "json":
                            result = eval("(" + xhr.responseText.replace(/[\n\r]/g, "") + ")");
                            break;
                        case "xml":
                            result = xhr.responseXML;
                            break;
                        default:
                            result = xhr.responseText;
                    }
                    callback(result);
                } else {
                    if (xhr.error) xhr.error(xhr.status);
                }
            }
        }
        xhr.send(parameters);
    }
}

function checkAutoRun() {
    if ($('#autocmd') && !$('#autocmd').checked) return;
    runCommandFromMemory();
    setTimeout(checkAutoRun, 3000);
}

function runCommand(cmd) {
    console.log("Running " + cmd);
    window.curcmd = cmd;
    jx.load('/cgi-bin/ajaxcmd.cgi?cmd=' + urlencode(cmd), handler, 'text', 'POST');
    return false;
}

function runCommandFromMemory() {
    if (typeof window.curcmd !== 'undefined') runCommand(window.curcmd);
}

function runCommandFromMenu(event) {
    $$('aside dd.on').forEach(el => el.classList.remove('on'))
    event.target.parentElement.classList.add('on');

    if ($('#cmd')) {
        $("#cmd input").value = event.target.dataset.command;
        $("#cmd input").focus();
    } else {
        runCommand(event.target.dataset.command);
    }
}

function runCommandFromWeb(event) {
    if (event.keyCode && event.keyCode !== 13) return;
    const cmd = $('#cmd input').value;
    return runCommand(cmd);
}

// function expandList() {
//     $('aside').classList.add('expand');
//     $('aside > dl').classList.remove('d-none');
//     if (!$('aside > p')) $('aside').prepend(document.createElement('p'));
//     $('aside > p').classList.add('d-none');
// }
//
// function collapseList() {
//     $('aside').classList.remove('expand');
//
//     if (!$('aside > p')) $('aside').prepend(document.createElement('p'));
//     if ($('aside > dl dd.on a')) {
//         $('aside > p').textContent = $('aside > dl dd.on a').dataset.command;
//     } else {
//         $('aside > p').textContent = 'Select a command';
//     }
//     $('aside > p').classList.remove('d-none');
//     $('aside > dl').classList.add('d-none');
//     // if ($('aside > dl') && $('aside > dl dd.on')) $('aside > dl').scrollTo(0, $('aside > dl dd.on').offsetTop);
// }

function reportWindowSize() {
    document.body.style.height = document.body.scrollHeight + "px";
    const el = $('aside dd.on a');
    if (el) el.click();
}

function initAll() {
    window.addEventListener('resize', reportWindowSize);
    reportWindowSize();

    // $('aside').addEventListener('mouseover', expandList);
    // $('aside').addEventListener('mouseleave', collapseList);
    // collapseList();

    $$('a[data-command]').forEach(el => el.addEventListener('click', runCommandFromMenu));

    if ($('#autocmd')) $('#autocmd').addEventListener('click', checkAutoRun);

    if ($('#cmd input')) $('#cmd input').addEventListener('keyup', runCommandFromWeb);
    if ($('#cmd button')) $('#cmd button').addEventListener('click', runCommandFromWeb);

    $$('a[href^=http]').forEach(el => el.target = '_blank');
    checkAutoRun();
}

window.onload = initAll;
