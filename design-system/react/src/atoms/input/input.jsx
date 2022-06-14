import React from 'react';
import PropTypes from 'prop-types';
import {isValid} from 'ipaddr.js';
/**
 * Primary UI component for user interaction
 */
 export const Input = ({ id, placeholder, onData, isValid, type, label }) => {

  function onInput (InputEvent)
  {
    console.log("Input.onData",InputEvent);
    if(typeof onData==='function'){
      onData(InputEvent.target.value);
    }
  }

  const message= isValid ? "valore corretto" : "valore errato"
  return (
    <>
      <input id={id}
      onInput={onInput}
      placeholder={placeholder}
      type={type}
    >
    </input>

    {label===undefined ? null : <label htmlFor={id}>{label}</label>}
    {isValid===undefined ? null : message}
    </>
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
  onData: undefined,
  type: "text",
  onData: undefined,
  isValid: undefined,
  placeholder: undefined,
  label: undefined,
};

