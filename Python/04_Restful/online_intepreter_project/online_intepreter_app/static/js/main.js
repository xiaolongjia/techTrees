//api

const api = {
    v1: {  // api version
        codes: { // code api under api v1
            list: function () { //acquire set of instances
                return '/api/v1/codes/'
            },
            detail: function (pk) { // acquire single instance
                return `/api/v1/codes/${pk}/`
            },
            create: function () { // create instance
                return `/api/v1/codes/`
            },
            update: function (pk) { // update instance
                return `/api/v1/codes/${pk}/`
            },
            remove: function (pk) { //delete instance
                return `/api/v1/codes/${pk}/`
            },
            run: function () { //run code
                return '/api/v1/codes/run/'
            },
            runSave: function () {// run and save code
                return '/api/v1/codes/run/?save=true'
            },
            runSpecific: function (pk) { // run specific code instance
                return `/api/v1/codes/run/${pk}/`
            },
            runSaveSpecific: function (pk) { // run and save specific code instance
                return `/api/v1/codes/run/${pk}/?save=true`
            }
        }
    }
};


//store to check state, UI listen to changed variable
let store = {
    list: { //list state
        state: undefined,
        changed: false
    },
    detail: { //specific state
        state: undefined,
        changed: false
    },
    output: { //output state
        state: undefined,
        changed: false
    }
};


//add pk field to other fields
function getInstance(data) {
    let instance = data.fields;
    instance.pk = data.pk;
    return instance
}

//acquire code list，change list state
function getList() {
    $.getJSON({
        url: api.v1.codes.list(),
        success: function (data) {
            store.list.state = data.instances;
            store.list.changed = true;
        }
    })
}
//create code instance, change list state.
function create(code, name) {
    $.post({
        url: api.v1.codes.create(),
        data: {'code': code, 'name': name},
        dataType: 'json',
        success: function (data) {
            getList();
            alert('Saved!');
        }
    })
}
//update code instance, and update list state。
function update(pk, code, name) {
    $.ajax({
        url: api.v1.codes.update(pk),
        type: 'PUT',
        data: {'code': code, 'name': name},
        dataType: 'json',
        success: function (data) {
            getList();
            alert('Updated!');
        }
    })
}
//acquire instance, and update detail state 
function getDetail(pk) {
    $.getJSON({
        url: api.v1.codes.detail(pk),
        success: function (data) {
            let detail = getInstance(data.instances[0]);
            store.detail.state = detail;
            store.detail.changed = true;
        }
    })
}
//delete instance, and update list state
function remove(pk) {
    $.ajax({
        url: api.v1.codes.remove(pk),
        type: 'DELETE',
        dataType: 'json',
        success: function (data) {
            getList();
            alert('Deleted!');
        }
    })
}
//run code, and update output state
function run(code) {
    $.post({
        url: api.v1.codes.run(),
        dataType: 'json',
        data: {'code': code},
        success: function (data) {
            let output = data.output;
            store.output.state = output;
            store.output.changed = true;
        }
    })
}
//run and save code, and update output state and list state
function runSave(code, name) {
    $.post({
        url: api.v1.codes.runSave(),
        dataType: 'json',
        data: {'code': code, 'name': name},
        success: function (data) {
            let output = data.output;
            store.output.state = output;
            store.output.changed = true;
            getList();
            alert('Saved!');
        }
    })
}
//run specific code instance, and update output state
function runSpecific(pk) {
    $.get({
        url: api.v1.codes.runSpecific(pk),
        dataType: 'json',
        success: function (data) {
            let output = data.output;
            store.output.state = output;
            store.output.changed = true;
        }
    })
}
//run and store specific code instance, and update output state and list  state
function runSaveSpecific(pk, code, name) {
    $.ajax({
        url: api.v1.codes.runSaveSpecific(pk),
        type:'PUT',
        dataType: 'json',
        data: {'code': code, 'name': name},
        success: function (data) {
            let output = data.output;
            store.output.state = output;
            store.output.changed = true;
            getList();
            alert('Saved');
        }
    })
}

//UI motion logic

//change size of input box based on input
function flexSize(selector) {
    let ele = $(selector);
    ele.css({
        'height': 'auto',
        'overflow-y': 'hidden'
    }).height(ele.prop('scrollHeight'))
}
//put function to input box
$('#code-input').on('input', function () {
    flexSize(this)
});

//render to table element
function renderToTable(instance, tbody) {
    let name = instance.name;
    let pk = instance.pk;
    let options = `\
    <button class='btn btn-primary' onclick="getDetail(${pk})">View</button>\
    <button class="btn btn-primary" onclick="runSpecific(${pk})">Run</button>\
    <button class="btn btn-danger" onclick="remove(${pk})">Delete</button>`;
    let child = `<tr><td class="text-center">${name}</td><td>${options}</td></tr>`;
    tbody.append(child);
}

//render code option

//when click view code, render code option actions.

function renderSpecificCodeOptions(pk) {
    let options = `\
    <button class="btn btn-primary" onclick="run($('#code-input').val())">Run</button>\
    <button class="btn btn-primary" onclick=\
    "update(${pk},$('#code-input').val(),$('#code-name-input').val())">Save Changed</button>\
    <button class="btn" onclick=\
    "runSaveSpecific(${pk}, $('#code-input').val(), $('#code-name-input').val())">Save and Run</button>\
    <button class="btn btn-primary" onclick="renderGeneralCodeOptions()">New</button>`;
    $('#code-options').empty().append(options);// empty previous option. append current option
}

//When clicked New, render code option 
function renderGeneralCodeOptions() {
    let options = `\
    <button class="btn btn-primary" onclick="run($('#code-input').val())">Run</button>\
    <button class="btn btn-primary" onclick=\
    "create($('#code-input').val(),$('#code-name-input').val())">Save</button>\
    <button class="btn btn-primary" onclick=\
    "runSave($('#code-input').val(),$('#code-name-input').val())">Save and Run</button>\
    <button class="btn btn-primary" onclick="renderGeneralCodeOptions()">New</button>`;
    $('#code-input').val('');// clear input box
    $('#code-output').val('');// clear output box
    $('#code-name-input').val('');// clear code name input box
    flexSize('#code-output');
    $('#code-options').empty().append(options);//  empty previous option. append current option
}

//UI listener 
function watcher() {
    for (let op in store) {
        switch (op) {
            case 'list':// when list state changed, refresh table
                if (store[op].changed) {
                    let instances = store[op].state;
                    let tbody = $('tbody');
                    tbody.empty();
                    for (let i = 0; i < instances.length; i++) {
                        let instance = getInstance(instances[i]);
                        renderToTable(instance, tbody);
                    }
                    store[op].changed = false; // reset to false state
                }
                break;
            case 'detail':
                if (store[op].changed) {// when detail state changed, renew code input box, code name input box, output box.
                    let instance = store[op].state;
                    $('#code-input').val(instance.code);
                    $('#code-name-input').val(instance.name);
                    $('#code-output').val('');// clear last ouput
                    flexSize('#code-input');// trigger box resize by hand
                    renderSpecificCodeOptions(instance.pk);// render code option
                    store[op].changed = false;// reset to false state
                }
                break;
            case 'output':
                if (store[op].changed) { //when output state changed, change output box state
                    let output = store[op].state;
                    $('#code-output').val(output);
                    flexSize('#code-output');// trigger box resize by hand
                    store[op].changed = false // reset to false state
                }
                break;
        }
    }
}
//add UI logic to time queue 

getList();// call when initialize page to show table.
renderGeneralCodeOptions();// 
setInterval("watcher()", 500);// set watcher to run per 500 millisecond, which is 0.5 second 



