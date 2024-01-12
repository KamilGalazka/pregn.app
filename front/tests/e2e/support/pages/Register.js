import Basic from "./Basic";

class Register extends Basic {
    inputNameLocator = '[data-cy="input-name"]'
    inputLastnameLocator = '[data-cy="input-lastname"]'
    inputEmailLocator = '[data-cy="input-email"]'
    inputPasswordLocator = '[data-cy="input-password"]'
    inputRepeatPasswordLocator = '[data-cy="input-repeat-password"]'
    checkboxTermsLocator = '[data-cy="checkbox-terms"]'
    registerAccountButtonLocator = '[data-cy="register-button"]'
    registrationSuccessfulAlertLocator = '[data-cy="registration-successful-alert"]'

    getInputName() {
        return cy.get(this.inputNameLocator)
    }

    getInputLastname() {
        return cy.get(this.inputLastnameLocator)
    }

    getInputEmail() {
        return cy.get(this.inputEmailLocator)
    }

    getInputPassword() {
        return cy.get(this.inputPasswordLocator)
    }

    getInputRepeatPassword() {
        return cy.get(this.inputRepeatPasswordLocator)
    }

    getCheckboxTerms() {
        return cy.get(this.checkboxTermsLocator)
    }

    getRegisterAccountButton() {
        return cy.get(this.registerAccountButtonLocator)
    }

    getRegistrationSuccessfulAlert() {
        return cy.get(this.registrationSuccessfulAlertLocator)
    }

    typeName(name) {
        this.getInputName()
            .type(name)
    }

    typeLastname(lastname) {
        this.getInputLastname()
            .type(lastname)
    }

    typeEmail(email) {
        this.getInputEmail()
            .type(email)
    }

    typePassword(password) {
        this.getInputPassword()
            .type(password)
    }

    typeRepeatPassword(password) {
        this.getInputRepeatPassword()
            .type(password)
    }

    checkCheckboxWithTerms() {
        this.getCheckboxTerms()
            .check()
    }

    clickRegisterAccountButton() {
        this.getRegisterAccountButton()
            .click()
    }
}

export default Register