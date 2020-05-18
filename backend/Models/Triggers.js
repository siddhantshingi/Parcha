let mysqlConfig = require("../Utilities/mysqlConfig"),
triggerDAO = require('../DAO/triggersDAO');

let initialize = () => {
	triggerDAO.updatetokensOnUserNameUpdate((err,data) => {});
	triggerDAO.updatetokensOnShopNameUpdate((err,data) => {});
	triggerDAO.updateRequestsOnShopUpdate((err,data) => {});
	triggerDAO.updateRequestsOnAuthUpdate((err,data) => {});
	triggerDAO.updateShopBookingOnInsertInToken((err,data) => {});
	triggerDAO.updateShopBookingOnUpdateInToken((err,data) => {});
	triggerDAO.updateShopOnResolveRequest((err,data) => {});
}

module.exports = {
	initialize: initialize
}