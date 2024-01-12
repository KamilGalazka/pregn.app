import Basic from "./Basic";

class OpeningPage extends Basic {
    openingPageButtonLocator = '[data-cy="opening-page__button"]'

    getOpeningPageButton() {
        return cy.get(this.openingPageButtonLocator)
    }

    clickOpeningPageButton() {
        this.getOpeningPageButton()
            .click()
    }
}

export default OpeningPage