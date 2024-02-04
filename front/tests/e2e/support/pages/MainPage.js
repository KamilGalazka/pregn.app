import Basic from "./Basic";

class MainPage extends Basic {
    headerLocator = 'h1'
    loginButtonLocator = '[data-cy="header__login-button"]'
    logoutButtonLocator = '[data-cy="header__logout-button"]'

    getHeader() {
        return cy.get(this.headerLocator)
    }

    getLoginButton() {
        return cy.get(this.loginButtonLocator)
    }

    getLogoutButton() {
        return cy.get(this.logoutButtonLocator)
    }

    clickLoginButton() {
        this.getLoginButton()
            .click()
    }

    clickLogoutButton() {
        this.getLogoutButton()
            .click()
    }
}

export default MainPage