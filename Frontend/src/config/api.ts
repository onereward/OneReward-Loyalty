// API Configuration for Two Services
export const getApiBaseUrl = (): string => {
  // Main API (Node.js service)
  const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:3000';
  console.log("🌐 Main API URL:", apiUrl);
  return apiUrl;
};

export const getQRServiceUrl = (): string => {
  // QR Service (Python service)
  const qrUrl = import.meta.env.VITE_QR_SERVICE_URL || 'http://localhost:5001';
  console.log("🌐 QR Service URL:", qrUrl);
  return qrUrl;
};

export const API_BASE_URL = getApiBaseUrl();
export const QR_SERVICE_URL = getQRServiceUrl();

// Helper function to get the correct URL for each endpoint
export const getApiUrl = (endpoint: string): string => {
  if (endpoint.includes('/generate_qr')) {
    return `${QR_SERVICE_URL}${endpoint}`;
  }
  return `${API_BASE_URL}${endpoint}`;
};
