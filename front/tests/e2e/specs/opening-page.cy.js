import OpeningPage from "../support/pages/OpeningPage"
import MainPage from "../support/pages/MainPage"

const openingPage = new OpeningPage()
const mainPage = new MainPage()

describe("Opening page tests", function () {

  beforeEach(function () {
    cy.fixture('main-page').then(function (data) {
      this.dataFromFixtures = data
    })
  })

  it("Open page and check if opening page is visible", function () {
    cy.visit("/")
    openingPage.getOpeningPageButton()
        .should('be.visible')
  })

  it("Open page and check if button on opening page is clickable and leads to main page", function () {
    const {headerText} = this.dataFromFixtures

    cy.visit("/")
    openingPage.clickOpeningPageButton()
    mainPage.getHeader()
        .should('contain', headerText)
  })

})
