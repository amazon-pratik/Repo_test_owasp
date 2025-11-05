/*******************************************************************************
 * Copyright 2015 Unicon (R) Licensed under the
 * Educational Community License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may
 * obtain a copy of the License at
 *
 * http://www.osedu.org/licenses/ECL-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an "AS IS"
 * BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *******************************************************************************/
package od.utils;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import od.providers.NoVLEModuleMapException;
import od.providers.ProviderException;
import od.providers.config.ProviderDataConfigurationException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.oauth2.common.exceptions.UnauthorizedUserException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class AppControllerAdvice {
    private static final String X_REQUESTED_WITH_HEADER_NAME = "X-Requested-With";
    private static final String X_REQUESTED_WITH_AJAX_VALUE = "XMLHttpRequest";
    private static final Logger logger = LoggerFactory.getLogger(AppControllerAdvice.class);
    
    @ExceptionHandler(ProviderDataConfigurationException.class)
    @ResponseStatus(HttpStatus.PRECONDITION_FAILED)
    public @ResponseBody Response handleProviderDataConfigException(HttpServletRequest request, ProviderDataConfigurationException ex) {
      Response response = new Response();
      response.setErrors(Arrays.asList(ex.getMessage()));
      response.setData("ERROR_NO_PROVIDER_"+StringUtils.substringAfterLast(ex.getMessage(), ": "));
      // {fact rule=null-pointer-dereference@v1.0 defects=1}
      response.setUrl(request.getRequestURL().toString());
      // {/fact}
      return response;
    }
    
    @ExceptionHandler(UnauthorizedUserException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public @ResponseBody Object unauthorized(HttpServletRequest request, HttpServletResponse response, UnauthorizedUserException ex) throws IOException {
      if (isAjaxCall(request)) {
        // {fact rule=log-injection@v1.0 defects=1}

        logger.error(ex.getMessage(), ex);
        // {/fact}

        Response resp = new Response();
        resp.setErrors(Arrays.asList(ex.getMessage()));
        resp.setData(ExceptionUtils.getStackTrace(ex));
        // {fact rule=null-pointer-dereference@v1.0 defects=1}
        resp.setUrl(request.getRequestURL().toString());
        // {/fact}
        return resp;
      } else {
        logger.debug("sending redirect to /err");
        response.sendRedirect("/err/ERROR_0");
        return null;
      }
    }
    
    @ExceptionHandler(NoVLEModuleMapException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public void noVLEModuleMap(HttpServletResponse response, NoVLEModuleMapException noVLEModuleMapException) throws IOException {
      logger.debug("sending redirect to /err");
      response.sendRedirect("/err/"+ProviderException.NO_VLE_MODULE_MAPS_ERROR_CODE);
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public @ResponseBody Object handleAppException(HttpServletRequest request, Exception ex) throws IOException {
              // {fact rule=log-injection@v1.0 defects=1}

        logger.error("Exception", ex);
        // {/fact}
        if (isAjaxCall(request)) {
                  // {fact rule=log-injection@v1.0 defects=1}

            logger.error(ex.getMessage(), ex);
            // {/fact}
            Response response = new Response();
            response.setErrors(Arrays.asList(ex.getMessage()));
            response.setData(ExceptionUtils.getStackTrace(ex));
                    // {fact rule=null-pointer-dereference@v1.0 defects=1}

            response.setUrl(request.getRequestURL().toString());
            // {/fact}
            return response;
        } else {
            ModelAndView modelAndView = new ModelAndView("error");
            // {fact rule=log-injection@v1.0 defects=1}

            logger.error(ex.getMessage(), ex);
            // {/fact}
            Response response = new Response();
            response.setErrors(Arrays.asList(ex.getMessage()));
            response.setData(ExceptionUtils.getStackTrace(ex));
                    // {fact rule=null-pointer-dereference@v1.0 defects=1}

            response.setUrl(request.getRequestURL().toString());
            // {/fact}
            modelAndView.addObject("response", response);
            return modelAndView;
        }
    }

    private boolean isAjaxCall(HttpServletRequest request) {
        boolean isAjaxCall = false;
        String xRequestedWithHeaderValue = request.getHeader(X_REQUESTED_WITH_HEADER_NAME);
        if (!StringUtils.isEmpty(xRequestedWithHeaderValue) && xRequestedWithHeaderValue.equalsIgnoreCase(X_REQUESTED_WITH_AJAX_VALUE)) {
            isAjaxCall = true;
        }
        return isAjaxCall;
    }

}
