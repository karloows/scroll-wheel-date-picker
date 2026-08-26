# Security Policy

## Scope

`scroll_wheel_date_picker` is a UI rendering package for Flutter with no network, storage, authentication, or credential handling. It does not process sensitive data, make external requests, or manage secrets.

**Attack surface:** Low. The primary risks are UI rendering bugs and widget lifecycle issues.

## Reporting a vulnerability

If you discover a security vulnerability, **do not open a public GitHub issue**. Instead:

1. **Email the maintainer** with details of the vulnerability. Include:
   - A clear description of the issue.
   - Steps to reproduce (if applicable).
   - The impact and severity.
   - Any suggested fixes or mitigations.

2. **Alternatively,** report via [GitHub Security Advisories](../../security/advisories/new) (private to maintainers).

## Response timeline

- **Acknowledgment:** Within 2-3 business days.
- **Investigation and fix:** Timelines vary by severity. Critical issues (e.g., arbitrary code execution) receive priority; lower-severity issues (e.g., UI glitches) may be bundled into regular releases.
- **Disclosure:** After a fix is released, a security advisory will be published on GitHub.

## What NOT to report here

General questions about Flutter security, best practices, or third-party dependency vulnerabilities should be directed to the Flutter team or the respective maintainers of those dependencies.

## Security best practices for users

- Keep `scroll_wheel_date_picker` and Flutter up to date.
- Run `flutter pub outdated` regularly to check for updates to this package and its dependencies.
- Report any widget rendering anomalies or unexpected behavior that could indicate a bug.
