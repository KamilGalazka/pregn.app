import OpeningPage from "../support/pages/OpeningPage"
import MainPage from "../support/pages/MainPage"
import Login from "../support/pages/Login";

const openingPage = new OpeningPage()
const mainPage = new MainPage()
const login = new Login()

describe("Login tests", function () {

    beforeEach(function () {
        cy.fixture('user').then(function (data) {
            this.dataFromFixtures = data
        })

        cy.fixture('main-page').then(function (data) {
            this.dataFromFixtures = {...this.dataFromFixtures, ...data}
        })
    })

    it("Open page, go to login page and login to app", function () {
        const {
            email,
            password,
            headerText,
        } = this.dataFromFixtures

        cy.visit('/')
        openingPage.clickOpeningPageButton()
        mainPage.clickLoginButton()
        login.typeEmail(email)
        login.typePassword(password)
        login.clickLoginToAccountButton()
        mainPage.getHeader()
            .should('contain', headerText)
    })

})
