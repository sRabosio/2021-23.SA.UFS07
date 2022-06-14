import React from 'react';
import PropTypes from 'prop-types';
import {isValid} from 'ipaddr.js';
/**
 * Primary UI component for user interaction
 */
export const Input = ({ label, onData, type}) => {
  function onInput(inputEvent){
      console.log("inputEvent.onData", inputEvent);
  }
  
    return (
    <Input
      onInput={onInput}
      type={type}
    >
      {label}
    </Input>
  );
};

Input.propTypes = {

  /**
   * Input contents
   */
  placeholder: PropTypes.string.isRequired,
  /**
   * Optional click handler
   */
  onData: PropTypes.func,

  type: PropTypes.string,

  isValid: PropTypes.bool.isRequired,
};

Input.defaultProps = {
  onData: gundefined,
  type: "text",
};

