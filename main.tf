terraform {
  required_version = ">= 1.5.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "khrapovs"
}

resource "github_repository" "order-book-matching-engine" {
  name                   = "OrderBookMatchingEngine"
  description            = "Simple Python implementation of order book matching engine"
  delete_branch_on_merge = true
  has_downloads          = true
  has_issues             = true
  has_wiki               = true
}
