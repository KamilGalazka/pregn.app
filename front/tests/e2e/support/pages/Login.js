import Basic from "./Basic";

class Login extends Basic {
    inputEmailLocator = '[data-cy="input-email"]'
    inputPasswordLocator = '[data-cy="input-password"]'
    invalidEmailLocator = '[data-cy="invalid-field__email"]'
    invalidPasswordLocator = '[data-cy="invalid-field__password"]'
    registerNewAccountButtonLocator = '[data-cy="register-account__button"]'
    loginToAccountButtonLocator = '[data-cy="login-button"]'

    getInputEmail() {
        return cy.get(this.inputEmailLocator)
    }

    getInputPassword() {
        return cy.get(this.inputPasswordLocator)
    }

    getInvalidEmail() {
        return cy.get(this.invalidEmailLocator)
    }

    getInvalidPassword() {
        return cy.get(this.invalidPasswordLocator)
    }

    getRegisterNewAccountButton() {
        return cy.get(this.registerNewAccountButtonLocator)
    }

    getLoginToAccountButton() {
        return cy.get(this.loginToAccountButtonLocator)
    }

    typeEmail(email) {
        this.getInputEmail()
            .type(email)
    }

    typePassword(password) {
        this.getInputPassword()
            .type(password)
    }

    clickRegisterNewAccountButton() {
        this.getRegisterNewAccountButton()
            .click()
    }

    clickLoginToAccountButton() {
        this.getLoginToAccountButton()
            .click()
    }

    loginToAccount(email, password) {
        this.typeEmail(email)
        this.typePassword(password)
        this.clickLoginToAccountButton()
    }
}

export default Login