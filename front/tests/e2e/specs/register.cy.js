import OpeningPage from "../support/pages/OpeningPage"
import MainPage from "../support/pages/MainPage"
import Login from "../support/pages/Login";
import Register from "../support/pages/Register";

const openingPage = new OpeningPage()
const mainPage = new MainPage()
const login = new Login()
const register = new Register()

describe("Register tests", function () {

    beforeEach(function () {
        cy.fixture('user').then(function (data) {
            this.dataFromFixtures = data
        })

        cy.fixture('main-page').then(function (data) {
            this.dataFromFixtures = {...this.dataFromFixtures, ...data}
        })
    })

    it("Open page, go to register page and create account", function () {
        const {
            name,
            lastname,
            new_account_email_prefix,
            new_account_email_postfix,
            password,
            headerText,
        } = this.dataFromFixtures

        const randomNumber = register.generateRandomNumber(999, 999999)
        const newEmailAddress = `${new_account_email_prefix}${randomNumber}${new_account_email_postfix}`

        cy.visit('/')
        openingPage.clickOpeningPageButton()
        mainPage.clickLoginButton()
        login.clickRegisterNewAccountButton()

        register.typeName(name)
        register.typeLastname(lastname)
        register.typeEmail(newEmailAddress)
        register.typePassword(password)
        register.typeRepeatPassword(password)
        register.checkCheckboxWithTerms()
        register.clickRegisterAccountButton()
        register.getRegistrationSuccessfulAlert()
            .should('be.visible')

        cy.wait(5000)
        login.loginToAccount(newEmailAddress, password)
        mainPage.getHeader()
            .should('contain', headerText)
    })

})
