/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License.
 */

let frozen = false;
let status = ':partly_sunny: oh no, looks like I rebooted - not sure of the freeze state sorry';
let rebooted = true;

module.exports = function(controller) {

    controller.on('slash_command', async(bot, message) => {
        if (message.text === 'help' || message.text === '') {
            await bot.reply(message, "What's the weather like for committing? `/weather status`\n Flag that we're in freeze `/weather freeze Waiting for 8.7.2 release`\n or good to commit `/thaw`\n or find out when the freeze ended `/weather extended-status`");
        } else if (message.text === 'thaw') {
            frozen = false;
            let now = new Date();
            rebooted = false;
            let profile = await bot.api.users.info({user: message.user});
            status = 'Cleared by ' + profile.user.name + ' on ' + now.toDateString();
            await bot.reply(message, ":sunny: Thanks, I'll be sure to tell others when they ask");
        }
        else if (message.text === 'extended-status') {
            if (rebooted) {
                await bot.reply(message, status);
            }
            else if (frozen) {
                await bot.reply(message, ":snowflake: Freeze active: " + status);
            }
            else {
                await bot.reply(message, ":sunny: " + status);
            }
        } else if (message.text === 'status') {
            if (rebooted) {
                await bot.reply(message, status);
            }
            else if (frozen) {
                await bot.reply(message, ":snowflake: Freeze active: " + status);
            }
            else {
                await bot.reply(message, ":sunny: Looks like you're good to go!");
            }
        } else if (message.text === 'extended-status') {
            if (frozen) {
                await bot.reply(message, ":snowflake: Freeze active: " + status);
            }
            else {
                await bot.reply(message, ":sunny: " + status);
            }
        } else if (message.text.substr(0, ('freeze').length) === 'freeze') {
            frozen = true;
            rebooted = false;
            let now = new Date();
            let profile = await bot.api.users.info({user: message.user});

            status = message.text.substr(('freeze').length + 1) + ' (' + profile.user.name + ' - ' + now.toDateString() + ')'
            await bot.reply(message, ":snowflake: Thanks, I'll be sure to tell others when they ask");
        }

    });

}
