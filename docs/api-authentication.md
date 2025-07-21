# API Authentication

The API uses Bearer token authentication to secure endpoints. All API requests must include a valid authentication token in the Authorization header.

## Authentication

### Bearer Token

Include your authentication token in the Authorization header:

```
Authorization: Bearer YOUR_AUTHENTICATION_TOKEN
```

### Getting Your Authentication Token

Your authentication token is provided when your droplet is installed. It's stored in the `authentication_token` field of your company record.

## API Endpoints

### Create Order

**POST** `/api/v1/orders`

Creates a new order in ShipStation.

#### Headers

```
Authorization: Bearer YOUR_AUTHENTICATION_TOKEN
Content-Type: application/json
```

#### Request Body

```json
{
  "order": {
    "orderNumber": "12345",
    "orderDate": "2024-01-15",
    "orderStatus": "awaiting_shipment",
    "customer": {
      "name": "John Doe",
      "email": "john@example.com"
    },
    "items": [
      {
        "sku": "SKU123",
        "name": "Product Name",
        "quantity": 1,
        "unitPrice": 29.99
      }
    ]
  }
}
```

#### Response

**Success (201 Created)**
```json
{
  "success": true,
  "data": {
    "orderId": "12345",
    "status": "created"
  }
}
```

**Error (422 Unprocessable Entity)**
```json
{
  "success": false,
  "error": "Order creation failed"
}
```

**Unauthorized (401 Unauthorized)**
```json
{
  "success": false,
  "error": "Invalid bearer token"
}
```

## Error Codes

- **401 Unauthorized**: Missing or invalid bearer token
- **403 Forbidden**: Company is not active
- **422 Unprocessable Entity**: Request validation failed
- **500 Internal Server Error**: Server error

## Example Usage

### cURL

```bash
curl -X POST \
  https://your-domain.com/api/v1/orders \
  -H "Authorization: Bearer YOUR_AUTHENTICATION_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "order": {
      "orderNumber": "12345",
      "orderDate": "2024-01-15"
    }
  }'
```

### JavaScript

```javascript
const response = await fetch('/api/v1/orders', {
  method: 'POST',
  headers: {
    'Authorization': 'Bearer YOUR_AUTHENTICATION_TOKEN',
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    order: {
      orderNumber: '12345',
      orderDate: '2024-01-15'
    }
  })
});

const result = await response.json();
```

## Security Notes

- Keep your authentication token secure and don't share it publicly
- The token is tied to your company and should be treated like a password
- If you suspect your token has been compromised, contact support to regenerate it
- All API requests should be made over HTTPS in production 