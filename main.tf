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

resource "github_branch" "main" {
  repository = github_repository.order-book-matching-engine.name
  branch     = "main"
}

resource "github_branch_default" "branch_default" {
  repository = github_repository.order-book-matching-engine.name
  branch     = github_branch.main.branch
}

resource "github_repository_ruleset" "main_branch" {
  name        = "Main branch"
  repository  = github_repository.order-book-matching-engine.name
  target      = "branch"
  enforcement = "active"

  bypass_actors {
    actor_id    = 4
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }

  conditions {
    ref_name {
      exclude = []
      include = [
        "~DEFAULT_BRANCH",
      ]
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true

    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_approving_review_count   = 0
      required_review_thread_resolution = true
    }

    required_status_checks {
      do_not_enforce_on_create             = false
      strict_required_status_checks_policy = false

      required_check {
        context        = "Build wheels"
        integration_id = 15368
      }
      required_check {
        context        = "Code quality checks"
        integration_id = 15368
      }
      required_check {
        context        = "Documentation"
        integration_id = 15368
      }
      required_check {
        context        = "Run benchmark"
        integration_id = 15368
      }
      required_check {
        context        = "Run unit tests (3.10)"
        integration_id = 15368
      }
      required_check {
        context        = "Run unit tests (3.11)"
        integration_id = 15368
      }
      required_check {
        context        = "Run unit tests (3.12)"
        integration_id = 15368
      }
    }
  }
}

