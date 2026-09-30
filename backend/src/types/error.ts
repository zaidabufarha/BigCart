export interface HttpError extends Error {
    statusCode?: number;
    // machine-readable reason, sent to the clients as extensions.code
    code?: string;
}
