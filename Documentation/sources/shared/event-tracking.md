# How event tracking works

This page outlines each event type generated by the AEPMessaging extension related to propositions, which includes in-app messages, content cards, and code-based experiences.

The following XDM event types are used in proposition tracking:

| Event Type | Description |
|----|----|
| `decisioning.propositionDismiss` | The proposition that was being displayed to the user has been removed from the user interface. |
| `decisioning.propositionDisplay` | The proposition has been displayed to the user. |
| `decisioning.propositionDisqualify` | The user has been permanently disqualified from seeing the proposition. |
| `decisioning.propositionInteract` | The user has interacted with the proposition that was displayed to them. |
| `decisioning.propositionSuppressDisplay` | Triggering criteria were met to display the proposition, but the SDK did not display it. |
| `decisioning.propositionTrigger` | Client-side criteria have been met to display the proposition to the user. |
| `personalization.request` | The client is making a request to Adobe servers for propositions (including in-app messages, content cards, and code-based experiences). |

The contents of XDM data for these events vary, and are derived based on the provided [MessagingEdgeEventType](./enums/enum-messaging-edge-event-type.md) enum value and, in some cases, additional parameters provided by the user or application developer.

## Sample personalization requests

This section provides __*partial*__ JSON payloads of sample edge request events that may be sent by the AEPMessaging extension.

> **Note**: The order in which the examples are given mimics the typical order seen in an application using in-app messaging.

### Request for propositions - personalization.request

An event similar to the following is emitted any time the SDK makes a request to Adobe servers for propositions:

```
{
    ...

    "events" : [
        {
            "query" : {
                "personalization" : {
                    "schemas" : [
                        "https:\/\/ns.adobe.com\/personalization\/html-content-item",
                        "https:\/\/ns.adobe.com\/personalization\/json-content-item",
                        "https:\/\/ns.adobe.com\/personalization\/ruleset-item"
                    ],
                    "surfaces" : [
                        "mobileapp:\/\/com.my.app.bundleIdentifier"
                    ]
                }
            },
            "data" : {
                "__adobe" : {
                    "ajo" : {
                        "in-app-response-format" : 2
                    }
                }
            },
            "xdm" : {
                "timestamp" : "2024-09-25T19:47:55.994Z",
                "_id" : "4729BDF3-E155-4AB4-85F8-93F0DC15C92C",
                "eventType" : "personalization.request"
            }
        }
    ]
}
```

### Proposition is triggered - decisioning.propositionTrigger

An event similar to the following is emitted any time a user has met the client-side criteria that qualifies them for a proposition:

```
{
    "events": [
        {
            "xdm": {
                "_id": "F8B3C334-A67D-4174-A0F2-4E00523F5D02",
                "eventType": "decisioning.propositionTrigger",
                "timestamp": "2024-09-25T19:48:16.092Z",
                "_experience": {
                    "decisioning": {
                        "propositionEventType": {
                            "trigger": 1
                        },
                        "propositions": [
                            {
                                "id": "4b6fe796-3e4c-476d-be62-8610d851daef",
                                "scope": "mobileapp://com.my.app.bundleIdentifier",
                                "scopeDetails": {
                                    "characteristics": {
                                        "eventToken": "<BASE64_ENCODED_STRING>"
                                    },
                                    "activity": {
                                        "id": "6aebeb06-faeb-4864-a27c-8be3efd6ff9b#876cb49a-7094-4f9e-9f9d-57ee26858462",
                                        "matchedSurfaces": [
                                            "mobileapp://com.my.app.bundleIdentifier/"
                                        ]
                                    },
                                    "correlationID": "7d0408d2-e9ed-4d66-b0a5-2659fc37e2a9-0",
                                    "decisionProvider": "AJO"
                                }
                            }
                        ]
                    }
                }
            }
        }
    ]
}
```

### Proposition is displayed - decisioning.propositionDisplay

An event similar to the following is emitted any time a proposition is displayed to the application's UI:

```
{
    "events": [
        {
            "xdm": {
                "_id": "F8B3C334-A67D-4174-A0F2-4E00523F5D02",
                "eventType": "decisioning.propositionDisplay",
                "timestamp": "2024-09-25T19:48:16.092Z",
                "_experience": {
                    "decisioning": {
                        "propositionEventType": {
                            "display": 1
                        },
                        "propositions": [
                            {
                                "id": "4b6fe796-3e4c-476d-be62-8610d851daef",
                                "scope": "mobileapp://com.my.app.bundleIdentifier",
                                "scopeDetails": {
                                    "characteristics": {
                                        "eventToken": "<BASE64_ENCODED_STRING>"
                                    },
                                    "activity": {
                                        "id": "6aebeb06-faeb-4864-a27c-8be3efd6ff9b#876cb49a-7094-4f9e-9f9d-57ee26858462",
                                        "matchedSurfaces": [
                                            "mobileapp://com.my.app.bundleIdentifier/"
                                        ]
                                    },
                                    "correlationID": "7d0408d2-e9ed-4d66-b0a5-2659fc37e2a9-0",
                                    "decisionProvider": "AJO"
                                }
                            }
                        ]
                    }
                }
            }
        }
    ]
}
```

### Proposition is interacted with - decisioning.propositionInteract

This event is emitted any time the user interacts with a message.

The values in the `xdm._experience.decisioning.propositionAction.id` and `xdm._experience.decisioning.propositionAction.label` properties are used to describe the interaction being taken.

```
{
    "events": [
        {
            "xdm": {
                "_id": "F8B3C334-A67D-4174-A0F2-4E00523F5D02",
                "eventType": "decisioning.propositionInteract",
                "timestamp": "2024-09-25T19:48:16.092Z",
                "_experience": {
                    "decisioning": {
                        "propositionEventType": {
                            "interact": 1
                        },
                        "propositionAction" : {
                            "id" : "clicked",
                            "label" : "clicked"
                        }
                        "propositions": [
                            {
                                "id": "4b6fe796-3e4c-476d-be62-8610d851daef",
                                "scope": "mobileapp://com.my.app.bundleIdentifier",
                                "scopeDetails": {
                                    "characteristics": {
                                        "eventToken": "<BASE64_ENCODED_STRING>"
                                    },
                                    "activity": {
                                        "id": "6aebeb06-faeb-4864-a27c-8be3efd6ff9b#876cb49a-7094-4f9e-9f9d-57ee26858462",
                                        "matchedSurfaces": [
                                            "mobileapp://com.my.app.bundleIdentifier/"
                                        ]
                                    },
                                    "correlationID": "7d0408d2-e9ed-4d66-b0a5-2659fc37e2a9-0",
                                    "decisionProvider": "AJO"
                                }
                            }
                        ]
                    }
                }
            }
        }
    ]
}
```

### Proposition is dismissed - decisioning.propositionDismiss

An event similar to the following is emitted any time a proposition is removed from the application's UI:

```
{
    "events": [
        {
            "xdm": {
                "_id": "F8B3C334-A67D-4174-A0F2-4E00523F5D02",
                "eventType": "decisioning.propositionDismiss",
                "timestamp": "2024-09-25T19:48:16.092Z",
                "_experience": {
                    "decisioning": {
                        "propositionEventType": {
                            "dismiss": 1
                        },
                        "propositions": [
                            {
                                "id": "4b6fe796-3e4c-476d-be62-8610d851daef",
                                "scope": "mobileapp://com.my.app.bundleIdentifier",
                                "scopeDetails": {
                                    "characteristics": {
                                        "eventToken": "<BASE64_ENCODED_STRING>"
                                    },
                                    "activity": {
                                        "id": "6aebeb06-faeb-4864-a27c-8be3efd6ff9b#876cb49a-7094-4f9e-9f9d-57ee26858462",
                                        "matchedSurfaces": [
                                            "mobileapp://com.my.app.bundleIdentifier/"
                                        ]
                                    },
                                    "correlationID": "7d0408d2-e9ed-4d66-b0a5-2659fc37e2a9-0",
                                    "decisionProvider": "AJO"
                                }
                            }
                        ]
                    }
                }
            }
        }
    ]
}
```

### Proposition was suppressed - decisioning.propositionSuppressDisplay

This event is emitted any time the triggering criteria are met for a message, but the SDK does not display the message.

The value in the `xdm._experience.decisioning.propositionAction.reason` property is used to describe why the display was suppressed.

#### Use case #1

Two full screen in-app messages were created with identical triggering criteria. The SDK will only display one full screen message at a time. In the event that triggering criteria has been met for both messages, the message with lower priority (configured in the AJO UI) will be suppressed and an event similar to the following will be emitted:

```
{
    "events": [
        {
            "xdm": {
                "_id": "F8B3C334-A67D-4174-A0F2-4E00523F5D02",
                "eventType": "decisioning.propositionSuppressDisplay",
                "timestamp": "2024-09-25T19:48:16.092Z",
                "_experience": {
                    "decisioning": {
                        "propositionEventType": {
                            "suppressDisplay": 1
                        },
                        "propositionAction" : {
                            "reason" : "Conflict"
                        }
                        "propositions": [
                            {
                                "id": "4b6fe796-3e4c-476d-be62-8610d851daef",
                                "scope": "mobileapp://com.my.app.bundleIdentifier",
                                "scopeDetails": {
                                    "characteristics": {
                                        "eventToken": "<BASE64_ENCODED_STRING>"
                                    },
                                    "activity": {
                                        "id": "6aebeb06-faeb-4864-a27c-8be3efd6ff9b#876cb49a-7094-4f9e-9f9d-57ee26858462",
                                        "matchedSurfaces": [
                                            "mobileapp://com.my.app.bundleIdentifier/"
                                        ]
                                    },
                                    "correlationID": "7d0408d2-e9ed-4d66-b0a5-2659fc37e2a9-0",
                                    "decisionProvider": "AJO"
                                }
                            }
                        ]
                    }
                }
            }
        }
    ]
}
```

#### Use case #2

An in-app message was created to show during app startup. The app user is performing a time-sensitive onboarding workflow during app startup. The application developer has implemented a [`MessagingDelegate`](./../inapp-messaging/advanced-guides/how-to-messaging-delegate.md), and decided to not show the in-app message for fear of disrupting the user. The message display is suppressed, and the SDK will emit an event similar to the following:

```
{
    "events": [
        {
            "xdm": {
                "_id": "F8B3C334-A67D-4174-A0F2-4E00523F5D02",
                "eventType": "decisioning.propositionSuppressDisplay",
                "timestamp": "2024-09-25T19:48:16.092Z",
                "_experience": {
                    "decisioning": {
                        "propositionEventType": {
                            "suppressDisplay": 1
                        },
                        "propositionAction" : {
                            "reason" : "SuppressedByAppDeveloper"
                        }
                        "propositions": [
                            {
                                "id": "4b6fe796-3e4c-476d-be62-8610d851daef",
                                "scope": "mobileapp://com.my.app.bundleIdentifier",
                                "scopeDetails": {
                                    "characteristics": {
                                        "eventToken": "<BASE64_ENCODED_STRING>"
                                    },
                                    "activity": {
                                        "id": "6aebeb06-faeb-4864-a27c-8be3efd6ff9b#876cb49a-7094-4f9e-9f9d-57ee26858462",
                                        "matchedSurfaces": [
                                            "mobileapp://com.my.app.bundleIdentifier/"
                                        ]
                                    },
                                    "correlationID": "7d0408d2-e9ed-4d66-b0a5-2659fc37e2a9-0",
                                    "decisionProvider": "AJO"
                                }
                            }
                        ]
                    }
                }
            }
        }
    ]
}
```