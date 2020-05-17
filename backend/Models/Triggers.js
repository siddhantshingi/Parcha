let mysqlConfig = require("../Utilities/mysqlConfig"),
triggerDAO = require('../DAO/triggersDAO');

let initialize = () => {
	triggerDAO.updatetokensOnUserNameUpdate((err,data) => {});
	triggerDAO.updatetokensOnShopNameUpdate((err,data) => {});
	triggerDAO.updateShopBookingOnInsertInToken((err,data) => {});
	triggerDAO.updateShopBookingOnUpdateInToken((err,data) => {});
}

module.exports = {
	initialize: initialize
}