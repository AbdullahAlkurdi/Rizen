# Security Policy

## 1. Introduction

Rizen is committed to protecting the security and privacy of its users.
This policy outlines our security practices, vulnerability reporting process,
and incident response procedures.

**Scope:** This policy applies to all Rizen software, services,
infrastructure, and data processing activities.

## 2. Reporting Vulnerabilities

We welcome responsible disclosure of security vulnerabilities from
security researchers and the broader community.

**Contact:** security@rizen.app

**Expected Response Time:** Within 48 hours of submission.

**Please include the following in your report:**

- Description of the vulnerability
- Steps to reproduce
- Potential impact assessment
- Suggested remediation (if any)
- Your contact information and preferred disclosure timeline

**Responsible Disclosure Process:**

1. Submit your report to security@rizen.app.
2. Our security team will acknowledge receipt within 48 hours.
3. We will investigate and provide an initial assessment within
   7 business days.
4. We will work with you to understand and address the issue.
5. Once resolved, we will coordinate public disclosure with you,
   allowing time for patches to be deployed.

**PGP Key:** A PGP public key for encrypted communication is available
upon request by contacting security@rizen.app.

**Please do not:**

- Access or modify data that does not belong to you.
- Exploit vulnerabilities beyond what is necessary to demonstrate
  the issue.
- Disclose the vulnerability publicly before we have had a reasonable
  opportunity to address it.

## 3. Security Practices

### Code Reviews

All code changes undergo mandatory peer review before merging.
Security-sensitive changes receive additional review by designated
security reviewers.

### Dependency Scanning

We continuously monitor project dependencies for known vulnerabilities
using automated scanning tools. Dependencies are updated promptly when
security patches are available.

### Static Code Analysis

We employ static application security testing (SAST) tools in our
continuous integration pipeline to identify potential security weaknesses
in Dart/Flutter code, configuration files, and infrastructure code.

### Penetration Testing

We are committed to conducting periodic penetration testing of Rizen
services. Formal third-party penetration assessments are planned on a
regular cadence aligned with our release schedule.

### Secret Management

All secrets, API keys, and credentials are managed through secure
channels and are never committed to version control. Environment
configuration is handled via secure, non-reproducible mechanisms.

## 4. Data Protection

### Encryption at Rest

All user data stored in Firebase services (Cloud Firestore, Firebase
Storage) is encrypted at rest using Google Cloud's infrastructure-level
encryption. Additional application-level encryption is applied to
sensitive fields where appropriate.

### Encryption in Transit

All communications between clients and servers use TLS 1.2 or higher.
We enforce HTTPS-only connections and HSTS policies.

### Logging

Sensitive information such as passwords, API keys, tokens, and personal
identifiable information (PII) is never written to application logs.
Structured logging captures only non-sensitive operational metadata.

### Firebase Security Rules

Cloud Firestore and Firebase Storage security rules are configured
following the principle of least privilege. Rules are reviewed and
tested with every relevant feature change.

## 5. Compliance

Rizen is designed to comply with applicable data protection regulations:

| Regulation | Scope | Status |
|---|---|---|
| GDPR | Users in the European Economic Area | Compliant |
| CCPA | Users in California, USA | Compliant |
| Saudi Arabia Personal Data Protection Law (PDPL) | Users in Saudi Arabia | Compliant |

## 6. Incident Response

### Detection

- Automated alerting for anomalous access patterns, failed
  authentication spikes, and infrastructure degradation.
- Regular log review by the operations team.
- User-reported anomalies via support channels.

### Notification

- Internal incident response team is notified immediately upon
  confirmed detection.
- Affected users are notified in accordance with applicable law
  and within agreed-upon service timelines.
- Communications are clear, timely, and include steps users can
  take to protect themselves.

### Mitigation

- Immediate containment of the affected service or component.
- Forensic analysis to determine scope and root cause.
- Deployment of patches or configuration changes.
- Post-incident review and remediation plan to prevent recurrence.

## 7. Contact

**Security Team:** security@rizen.app

**Emergency Contact:** For time-sensitive security incidents, please
use the above email address and include "URGENT" in the subject line.

## 8. Acknowledgments

We gratefully acknowledge the contributions of security researchers
and community members who help keep Rizen and its users safe.

A hall of fame recognizing responsible disclosures will be maintained
in this document (with reporter consent).

### Hall of Fame

_No entries yet — be the first to help us improve!_
