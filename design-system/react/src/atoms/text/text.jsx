import React from 'react';
import PropTypes from 'prop-types';

export const Text = ({label}) =>{
    return(
        <span>{label}</span>
    )
};

Text.prototype = {

};

Text.defaultProps = {
    label: undefined,
};
