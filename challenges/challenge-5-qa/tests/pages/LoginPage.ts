import { Page, Locator } from '@playwright/test';
import { BasePage } from './BasePage';

/**
 * Login Page Object
 * Handles all interactions with the login page
 *
 * NOTE: This page object contains 3 intentional bugs.
 * Use Copilot to help you find and fix them. Try pasting the
 * error messages from test failures into Copilot Chat.
 */
export class LoginPage extends BasePage {
  // Locators - update these selectors for your target application
  readonly usernameInput: Locator;
  readonly passwordInput: Locator;
  readonly submitButton: Locator;
  readonly errorMessage: Locator;
  readonly forgotPasswordLink: Locator;
  readonly registerLink: Locator;
  
  constructor(page: Page) {
    super(page);
    
    this.usernameInput = page.locator('[data-testid="user-name-field"]').first();
    this.passwordInput = page.locator('[data-testid="password"], #password, input[name="password"], input[type="password"]').first();
    this.submitButton = page.locator('[data-testid="login-submit"], button[type="submit"], input[type="submit"]').first();
    this.errorMessage = page.locator('.error-message, .alert-danger, [role="alert"]').first();
    this.forgotPasswordLink = page.locator('a[href*="forgot"], a[href*="reset"]').first();
    this.registerLink = page.locator('a[href*="register"], a[href*="signup"]').first();
  }
  
  async goto(): Promise<void> {
    await this.page.goto('/login');
  }
  
  async waitForLoad(): Promise<void> {
    await this.usernameInput.waitFor({ state: 'visible' });
  }
  
  /**
   * Perform login with credentials
   */
  async login(username: string, password: string): Promise<void> {
    await this.usernameInput.fill(username);
    await this.passwordInput.fill(password);
    this.submitButton.click();
  }
  
  /**
   * Get the error message text if visible
   */
  async getErrorMessage(): Promise<string | null> {
    return await this.errorMessage.innerText();
  }
  
  /**
   * Check if login form is displayed
   */
  async isDisplayed(): Promise<boolean> {
    return await this.usernameInput.isVisible();
  }
  
  /**
   * Navigate to registration page
   */
  async goToRegister(): Promise<void> {
    await this.registerLink.click();
  }
  
  /**
   * Navigate to forgot password page
   */
  async goToForgotPassword(): Promise<void> {
    await this.forgotPasswordLink.click();
  }
}
