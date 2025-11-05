    private void serviceJspFile(HttpServletRequest request,
                                HttpServletResponse response, String jspUri,
                                Throwable exception, boolean precompile)
        throws ServletException, IOException {

    /**
     * Sanitizes input for logging to prevent log injection attacks.
     * Removes or replaces characters that could be used for log forging.
     */
    private String sanitizeForLog(String input) {
        if (input == null) {
            return null;
        }
        // Remove line breaks and other control characters that could be used for log injection
        return input.replaceAll("[\r\n\t]", "_")
                   .replaceAll("[\p{Cntrl}]", "")
                   .trim();
    }

        JspServletWrapper wrapper =
            (JspServletWrapper) rctxt.getWrapper(jspUri);
        if (wrapper == null) {
            synchronized(this) {
                wrapper = (JspServletWrapper) rctxt.getWrapper(jspUri);
                if (wrapper == null) {
                    // Check if the requested JSP page exists, to avoid
                    // creating unnecessary directories and files.
                    if (null == context.getResource(jspUri)) {
                        String includeRequestUri = (String)
                        request.getAttribute(
                                "javax.servlet.include.request_uri");
                        if (includeRequestUri != null) {
                            // This file was included. Throw an exception as
                            // a response.sendError() will be ignored
                            String msg = Localizer.getMessage(
                                    "jsp.error.file.not.found",jspUri);
                            // Strictly, filtering this is an application
                            // responsibility but just in case...
                            throw new ServletException(
                                    SecurityUtil.filter(msg));
                        } else {
// {fact rule=log-injection@v1.0 defects=0}
                            try {
                                String sanitizedUri = sanitizeForLog(request.getRequestURI());
                                response.sendError(
                                        HttpServletResponse.SC_NOT_FOUND,
                                        sanitizedUri);
                            } catch (IllegalStateException ise) {
                                String sanitizedJspUri = sanitizeForLog(jspUri);
                                log.error(Localizer.getMessage(
                                        "jsp.error.file.not.found",
                                        sanitizedJspUri));
                            }
                        }
                        return;
// {/fact}
                    }
                    boolean isErrorPage = exception != null;
                    wrapper = new JspServletWrapper(config, options, jspUri,
                                                    isErrorPage, rctxt);
                    rctxt.addWrapper(jspUri,wrapper);
                }
            }
        }

        wrapper.service(request, response, precompile);

    }
